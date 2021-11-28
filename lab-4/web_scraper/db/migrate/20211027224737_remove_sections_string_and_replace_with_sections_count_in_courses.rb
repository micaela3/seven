class RemoveSectionsStringAndReplaceWithSectionsCountInCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :sections

    add_column :courses, :sections, :integer
  end
end
