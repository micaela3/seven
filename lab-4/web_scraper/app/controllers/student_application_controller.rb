class StudentApplicationController < ApplicationController
  def new
    @student_application = StudentApplication.new
  end
end
