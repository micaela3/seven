class AddStudentNameToInstructorMigration < ActiveRecord::Migration[6.1]
  def change
    remove_column :instructor_recommendations, :message
    add_column :instructor_recommendations, :student_name, :string
    add_column :instructor_recommendations, :message, :string
  end
end
