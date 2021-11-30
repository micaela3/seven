class StudentApplicationController < ApplicationController
  def new
    @student_application = StudentApplication.new
  end
  def create
    @student_application = StudentApplication.new(user_params)
    if @student_application.save
      redirect_to root_path, notice: "Successfully Submitted Application"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:student_application).permit(:email, :phone_number, :desired_courses, :taken_courses, :availability)
  end
end
