class Settings::SettingsController < ApplicationController
  before_filter :someone_logged_in?
  def index
  end

  def username
    current_user.change_username(params[:username])
    render nothing: true
  end
end
