#code inspired from https://medium.com/swlh/web-scraper-application-with-ruby-on-rails-864dfaae6270
class CoursesSpider < Kimurai::Base
    @name = 'courses_spider'
    @engine = :mechanize
  
    def self.process(url)
      @start_urls = [url]
      self.crawl!
    end
  
    def parse(response, url:, data: {})
      #response.xpath("//div[@class='course ng-scope']").each do |course|
        #var course_name = course.css('h3.ng-binding')&.text&.squish
        #console.log(course_name)
        response.xpath("//div[@class='section-container ng-scope']").each do |course|

            item = {}
  
            #item[:course_name]  = course_name
            item[:section]      = course.css('span.lightweight ng-binding')&.text&.squish
            #item[:class_type]   = course.css('span.sr-only sr-only-focusable ng-binding')&.text&.squish
            #item[:autoenroll]   = course.css('span.listing-row__mileage')&.text&.squish&.delete('^0-9').to_i
            #item[:weekdays]     = course.css('ul.listing-row__meta li')[0]&.text&.squish.gsub('Ext. Color: ', '')
            #item[:time]         = course.css('ul.listing-row__meta li')[1]&.text&.squish.gsub('Int. Color: ', '')
            #item[:course_id]    = course.css('ul.listing-row__meta li')[2]&.text&.squish.gsub('Transmission: ', '')
            #item[:seating]      = course.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')
            #item[:instructor]   = course.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')

            Course.where(item).first_or_create
        #end
      end
    end
  end