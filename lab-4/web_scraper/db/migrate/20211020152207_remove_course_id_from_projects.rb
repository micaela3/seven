class RemoveCourseIdFromProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :course_id, :string
  end
end
