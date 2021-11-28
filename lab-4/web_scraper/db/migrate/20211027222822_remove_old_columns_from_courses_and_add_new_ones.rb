class RemoveOldColumnsFromCoursesAndAddNewOnes < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :section
    remove_column :courses, :class_type
    remove_column :courses, :autoenroll
    remove_column :courses, :weekdays
    remove_column :courses, :time
    remove_column :courses, :seating
    remove_column :courses, :instructor

    add_column :courses, :sections, :string
    add_column :courses, :instructors, :string
    add_column :courses, :course_id, :string
  end
end
