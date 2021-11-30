class InstructorRecommendationController < ApplicationController
  def new
    @instructor_recommendation = InstructorRecommendation.new
  end

  def create
    @instructor_recommendation = InstructorRecommendation.new(user_params)
    if @instructor_recommendation.save
      redirect_to root_path, notice: "Successfully Submittes Recommendation"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:instructor_recommendation).permit(:name, :email, :message)
  end
end
