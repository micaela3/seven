class AddGradersToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :graders, :string
  end
end
