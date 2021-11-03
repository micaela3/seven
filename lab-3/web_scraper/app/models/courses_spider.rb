# Code inspired from https://medium.com/swlh/web-scraper-application-with-ruby-on-rails-864dfaae6270
require 'rubygems'
require 'kimurai'
require 'selenium-webdriver'
require 'nokogiri'

class CoursesSpider < Kimurai::Base
  @name = 'courses_spider'
  @engine = :selenium_firefox

  # This method required for Kimurai
  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    # Iterate through the whole page
    sleep 2
    response = browser.current_response
    item = {}

    # Scroll page all the way down. Code borrowed from Kimurai
    # documentation at https://github.com/vifreefly/kimuraframework
    count = response.css('div.course').count
    loop do
      browser.execute_script("window.scrollBy(0,10000)")
      sleep 2
      response = browser.current_response
      new_count = response.css('div.course').count
      if count == new_count # Pagination is done
        break
      else # Pagination is not yet done
        count = new_count
      end
    end

    # Iterate through each class section on the page
    response.css('div.section-container').each do |section|
      # Get the name of the course
      course_name = section.css('span.sr-only-focusable')&.text
      section_name = section.css('span.lightweight')&.text&.squish
      item[:course_name_and_section] = course_name + section_name

      # Get the section number
      item[:section] = section_name

      # Create list of instructors
      instructors = Array.new()
      section.css('li.right').each do |instructor|
        instructors << instructor&.text&.squish
      end

      # Remove duplicate instructors, convert to string,
      # format prettily, and store
      instructors = instructors.uniq
      instructors = instructors.to_s
      instructors.gsub!('[', '')
      instructors.gsub!(']', '')
      instructors.gsub!('"', '')
      item[:instructor] = instructors

      # gets weekdays for section
      course_weekdays = section.css("p[ng-bind='setDays(meeting)']")[0]&.text&.squish
      item[:weekdays] = course_weekdays

      #gets meeting time for section
      course_times = section.css("div[ng-show='meeting.startTime']")[0]&.text&.squish
      item[:times] = course_times

      # gets building and room name for section
      building_name = section.css("div[class='col-md-6 col-sm-7']").css('p.ng-binding')[0]&.text&.squish
      room_number = section.css("div[class='col-md-6 col-sm-7']").css('h4.ng-binding').css("span[ng-if='meeting.room']")&.text&.squish
      course_room = building_name + room_number
      item[:room] = course_room

      # sets attribute to be whether it is a lab, lecture, or independent study
      course_class_type = section.css("div[class='col-xs-9']").css('h4.ng-binding')&.text&.squish
      if course_class_type.include? "Laboratory"
        course_class_type = "Laboratory"
      elsif course_class_type.include? "Lecture"
        course_class_type = "Lecture"
      elsif course_class_type.include? "Independent Study"
        course_class_type = "Independent Study"
      end
      item[:class_type] = course_class_type

    #Add all scraped data to the database
    Course.where(item).first_or_create
    end
  end
end
