class AddUserToInstructorRecommendations < ActiveRecord::Migration[6.1]
  def change
    add_reference :instructor_recommendations, :users
  end
end
