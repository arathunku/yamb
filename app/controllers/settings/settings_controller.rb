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

  def html
    @html = current_user.design
  end

  def html_update
    design = current_user.design
    design.update_code(:html, params[:design][:html])
    redirect_to settings_html_path
  end

end
