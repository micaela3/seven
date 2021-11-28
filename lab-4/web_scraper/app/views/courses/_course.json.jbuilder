json.extract! course, :id, :course_name, :section, :class_type, :autoenroll, :weekdays, :time, :seating, :instructor, :created_at, :updated_at
json.url course_url(course, format: :json)
