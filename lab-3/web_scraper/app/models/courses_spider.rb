#code inspired from https://medium.com/swlh/web-scraper-application-with-ruby-on-rails-864dfaae6270
require 'kimurai'
class CoursesSpider < Kimurai::Base
  @name = 'courses_spider'
  @engine = :selenium_firefox

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    # Iterate through the whole page
    response.css('div.course').each do |course|
      item = {}
      item[:course_name] = course.css('h3.ng-binding')&.text&.squish

      item[:sections] = 0
      # Iterate through the data for the current class
      course.css('div.section-container').each do |section|
        item[:sections] += 1
        Rails.logger.info "DEBUG: sections = #{item[:sections]}"
      end







      Course.where(item).first_or_create
    end
  end
end
