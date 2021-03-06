class StudentApplicationController < ApplicationController
  def index
    @applications = StudentApplication.all
  end

  # Check the existense of the student in the application, if not exists, it will allow the user to create a new application
  def new
    if current_user.student_application.present?
      redirect_to student_index_path, notice: "ERROR: You've already submitted an application."
    else
      @student_application = StudentApplication.new
    end
  end

  # This function allows the users to edit their student application
  def edit
    @student_application = current_user.student_application
    render :edit
  end

  # Clear table, then refresh the page
  def clear_table(do_refresh=true)
    ActiveRecord::Base.connection.truncate(:student_applications)
    if do_refresh
      redirect_back(fallback_location: root_path)
    end
  end

  # Update the student info, notify the user if failed to update
  def update
    @student_application = current_user.student_application
    if @student_application.update(params.require(:student_application).permit(:email, :name, :phone_number, :desired_courses, :taken_courses, :availability))
      redirect_to student_index_path, notice: "Successfully Updated Application" 
    else
      flash.now[:error] = "Application failed to update."
      render :edit
    end
  end

  # Create and save the student application, then redirect to student index page. It will render new and notify the users if they failed to submit the application
  def create
    @student_application = StudentApplication.new(user_params.merge(user_id: current_user.id))
    if @student_application.save
      current_user.student_application = @student_application
      redirect_to student_index_path, notice: "Successfully Submitted Application"
    else
      flash.now[:error] = "Application failed to submit."
      render :new
    end
  end

  private
  def user_params
    params.require(:student_application).permit(:email, :name, :phone_number, :desired_courses, :taken_courses, :availability)
  end
end
