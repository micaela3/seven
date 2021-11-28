class RenameCourseNameToCourseAndSection < ActiveRecord::Migration[6.1]
  def change
    rename_column :courses, :course_name, :course_name_and_section
  end
end
