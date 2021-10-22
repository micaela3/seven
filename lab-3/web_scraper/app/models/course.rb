class Course < ApplicationRecord
  @name = 'course'
  @engine= :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    response.xpath("//duv[@class=course']").each do |course|
      item = {}
    item[:course_name] = course.css('h3.ng-binding')&.text&.squish
    item[:sections]    = course.css('span.lightweight')&.text&.squish
    # TODO: class_type
    # TODO: autoenroll
    # TODO: weekdays
    # TODO: time
    # TODO: seating
    # TODO: instructor

  end
end
