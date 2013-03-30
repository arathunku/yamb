module SettingsHelper
  include AuthorizationsHelper

  def someone_logged_in?
    redirect_to root_url unless signed_in?
  end
end
