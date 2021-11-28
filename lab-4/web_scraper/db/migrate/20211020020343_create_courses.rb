class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.integer :section
      t.string :class_type
      t.integer :autoenroll
      t.string :weekdays
      t.string :time
      t.string :course_id
      t.string :seating
      t.string :instructor

      t.timestamps
    end
  end
end
