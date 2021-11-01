class ChangeScrapedAttributes < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :sections
    remove_column :courses, :instructors
    remove_column :courses, :course_id

    add_column :courses, :section, :string
    add_column :courses, :instructor, :string
    add_column :courses, :weekdays, :string
    add_column :courses, :times, :string
    add_column :courses, :class_type, :string
    add_column :courses, :room, :string
  end
end
