class StudentApplicationController < ApplicationController
  def index
    @applications = StudentApplication.all
  end

  def new
    @student_application = StudentApplication.new
  end

  # Clear table, then refresh the page
  def clear_table(do_refresh=true)
    ActiveRecord::Base.connection.truncate(:student_applications)
    if do_refresh
      redirect_back(fallback_location: root_path)
    end
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
    params.require(:student_application).permit(:email, :name, :phone_number, :desired_courses, :taken_courses, :availability)
  end
end
