#code inspired from https://medium.com/swlh/web-scraper-application-with-ruby-on-rails-864dfaae6270
require 'rubygems'
require 'kimurai'
require 'selenium-webdriver'
require 'nokogiri'
class CoursesSpider < Kimurai::Base
  @name = 'courses_spider'
  @engine = :selenium_firefox

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    # Iterate through the whole page
    sleep 2
    response = browser.current_response
    item = {}

    count = response.css('div.course').count
    loop do
      browser.execute_script("window.scrollBy(0,10000)")
      sleep 2
      Rails.logger.info "DEBUG: just scrolled. count = #{count}"
      response = browser.current_response
      new_count = response.css('div.course').count
      Rails.logger.info "DEBUG: just scrolled. new_count = #{new_count}"
      if count == new_count # Pagination is done
        break
      else # Pagination is not yet done
        count = new_count
      end
    end
    Rails.logger.info "DEBUG: finished scrolling, now scraping"

    # Iterate through each class section on the page
    response.css('div.section-container').each do |section|
      course_name = section.css('span.sr-only-focusable')&.text
      section_name = section.css('span.lightweight')&.text&.squish
      item[:course_name_and_section] = course_name + section_name

      item[:section] = section_name

      # Create list of instructors
      instructors = Array.new()
      section.css('li.right').each do |instructor|
        instructors << instructor&.text&.squish
        Rails.logger.info "DEBUG: instructors2 = #{instructors}"
      end

      # gets weekdays for section
      course_weekdays = section.css("p[ng-bind='setDays(meeting)']")[0]&.text&.squish
      Rails.logger.info "DEBUG: weekdays = #{course_weekdays} end of debug statement"
      item[:weekdays] = course_weekdays

      #gets meeting time for section
      course_times = section.css("div[ng-show='meeting.startTime']")[0]&.text&.squish
      Rails.logger.info "DEBUG: times = #{course_times} end of debug statement"
      item[:times] = course_times

      # gets building and room name for section
      building_name = section.css("div[class='col-md-6 col-sm-7']").css('p.ng-binding')[0]&.text&.squish
      room_number = section.css("div[class='col-md-6 col-sm-7']").css('h4.ng-binding').css("span[ng-if='meeting.room']")&.text&.squish
      course_room = building_name + room_number
      Rails.logger.info "DEBUG: building = #{building_name} end of debug statement"
      Rails.logger.info "DEBUG: room number = #{room_number} end of debug statement"
      # course_room = section.css("div[class='col-md-6 col-sm-7']").css('p.ng-binding')&.text&.squish
      # Rails.logger.info "DEBUG: room = #{course_room} end of debug statement"
      item[:room] = course_room

      # I accidentally found out that this next line gives instruction mode (whether it is distance learning or in person)
      # so we can add that as an attribute if you guys want! -micaela
      # course_class_type = section.css("div[class='col-xs-9']").css('p.ng-binding')[0]&.text&.squish

      # sets attribute to be whether it is a lab, lecture, or independent study
      course_class_type = section.css("div[class='col-xs-9']").css('h4.ng-binding')&.text&.squish
      if course_class_type.include? "Laboratory"
        course_class_type = "Laboratory"
      elsif course_class_type.include? "Lecture"
        course_class_type = "Lecture"
      elsif course_class_type.include? "Independent Study"
        course_class_type = "Independent Study"
      end
      Rails.logger.info "DEBUG: class type = #{course_class_type} end of debug statement"
      item[:class_type] = course_class_type


      item[:section] = section_name

      # Remove duplicates, convert to string, format prettily, and store
      instructors = instructors.uniq
      instructors = instructors.to_s
      instructors.gsub!('[', '')
      instructors.gsub!(']', '')
      instructors.gsub!('"', '')
      item[:instructor] = instructors

    Course.where(item).first_or_create
    end
  end
end
