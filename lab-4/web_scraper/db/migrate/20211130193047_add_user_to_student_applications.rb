class AddUserToStudentApplications < ActiveRecord::Migration[6.1]
  def change
    add_reference :student_applications, :user
  end
end
