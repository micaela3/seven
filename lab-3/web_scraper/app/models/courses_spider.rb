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
    # sleep 2
    # response = browser.current_response
    # Rails.logger.info "DEBUG: response=#{response}"
    # temp = response.xpath("//div[@class='course']")
    # response.xpath("//div[@class='course']").each do |course|
    response.css('div.course').each do |course|
      item = {}
      # Rails.logger.info "DEBUG: course attribute title: #{course.css('h3.ng-binding').text}"
      #Rails.logger.info "#{response}"
      item[:course_name] = course.css('h3.ng-binding')&.text&.squish
      # item[:section]       = course.css('span.lightweight')&.text&.squish&.delete('^0-9').to_i
      # item[:class_type]   = course.css('span.sr-only sr-only-focusable ng-binding')&.text&.squish
      # item[:autoenroll]   = course.css('span.listing-row__mileage')&.text&.squish&.delete('^0-9').to_i
      # item[:weekdays]     = course.css('ul.listing-row__meta li')[0]&.text&.squish.gsub('Ext. Color: ', '')
      # item[:time]         = course.css('ul.listing-row__meta li')[1]&.text&.squish.gsub('Int. Color: ', '')
      # item[:course_id]    = course.css('ul.listing-row__meta li')[2]&.text&.squish.gsub('Transmission: ', '')
      # item[:seating]      = course.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')
      # item[:instructor]   = course.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')
      Course.where(item).first_or_create
    end
  end
end
