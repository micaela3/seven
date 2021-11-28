class ApplicationController < ActionController::Base
    # Before doing anything, users must sign up or log in
    before_action :authenticate_user!
end
