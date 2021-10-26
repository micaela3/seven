#code inspired from https://medium.com/swlh/web-scraper-application-with-ruby-on-rails-864dfaae6270
require 'kimurai'
class CoursesSpider < Kimurai::Base
  @name = 'courses_spider'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    Rails.logger.info "URL: #{url}"
    #response.xpath("/html/body/div[3]/div/div/div/div[4]/div[2]/div[1]/div[1]").each do |course|
    response.xpath("//div[@class='course']").each do |course|
      item = {}
      Rails.logger.info "IN COURSE CLASS"
      #Rails.logger.info "#{response}"
      Rails.logger.info "COURSE NAME: #{response.xpath("//span[@class='course-title']/*").text.squish}"
      #item[:course_name] = response.xpath("//span[@class='course-title']/*").text
      #item[:course_name] = course.css('//*[@id="main"]/div/div[4]/div[2]/div[1]/div[1]/div[1]/div/h3/text()')&.text&.squish
      #iterm[:course_name] = course.css('h3.ng-binding')&.text&.squish
      #item[:section]       = course.css('span.lightweight')&.text&.squish&.delete('^0-9').to_i
      #item[:class_type]   = course.css('span.sr-only sr-only-focusable ng-binding')&.text&.squish
      #item[:autoenroll]   = course.css('span.listing-row__mileage')&.text&.squish&.delete('^0-9').to_i
      #item[:weekdays]     = course.css('ul.listing-row__meta li')[0]&.text&.squish.gsub('Ext. Color: ', '')
      #item[:time]         = course.css('ul.listing-row__meta li')[1]&.text&.squish.gsub('Int. Color: ', '')
      #item[:course_id]    = course.css('ul.listing-row__meta li')[2]&.text&.squish.gsub('Transmission: ', '')
      #item[:seating]      = course.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')
      #item[:instructor]   = course.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')
      Course.where(item).first_or_create
      #save_to ""
    end
  end
end
