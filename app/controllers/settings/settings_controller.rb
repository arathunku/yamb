class Settings::SettingsController < ApplicationController
  before_filter :someone_logged_in?

  def index
    @user = current_user
  end

  def username
    current_user.change_username(params[:user][:username])
    respond_to do |format|
      format.html { redirect_to settings_path }
      format.js { render js: "window.location = '#{settings_path}'"}
    end
  end
end
