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

    # Iterate through each class section on the page
    response.css('div.section-container').each do |section|
      course_name = section.css('span.sr-only-focusable')&.text
      section_name = section.css('span.lightweight')&.text&.squish
      item[:course_name_and_section] = course_name + section_name

      item[:sections] = 0

      # Create list of instructors
      instructors = Array.new()
      section.css('li.right').each do |instructor|
        instructors << instructor&.text&.squish
        Rails.logger.info "DEBUG: instructors2 = #{instructors}"
      end

      # Remove duplicates, convert to string, format prettily, and store
      instructors = instructors.uniq
      instructors = instructors.to_s
      instructors.gsub!('[', '')
      instructors.gsub!(']', '')
      instructors.gsub!('"', '')
      item[:instructors] = instructors

    Course.where(item).first_or_create
    end
  end
end
