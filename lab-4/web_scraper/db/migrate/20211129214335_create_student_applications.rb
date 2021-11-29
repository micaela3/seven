class CreateStudentApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :student_applications do |t|
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :desired_courses
      t.string :taken_courses
      t.string :availability

      t.timestamps
    end
  end
end
