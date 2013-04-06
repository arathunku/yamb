class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include AuthorizationsHelper
  include PersonacodeHelper
  include SettingsHelper
  include MarkdownHelper
end
