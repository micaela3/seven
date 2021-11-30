class InstructorRecommendationController < ApplicationController
  def index
    @recommendations = InstructorRecommendation.all
  end

  def new
    @instructor_recommendation = InstructorRecommendation.new
  end

  # Clear table, then refresh the page
  def clear_table(do_refresh=true)
    ActiveRecord::Base.connection.truncate(:instructor_recommendations)
    if do_refresh
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @instructor_recommendation = InstructorRecommendation.new(user_params)
    if @instructor_recommendation.save
      redirect_to instructor_index_path, notice: "Successfully Submitted Recommendation"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:instructor_recommendation).permit(:name, :email, :student_name, :message)
  end
end
