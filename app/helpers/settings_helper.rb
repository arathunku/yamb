module SettingsHelper
  include AuthorizationsHelper

  def someone_logged_in?
    unless signed_in?
      respond_to do |format|
        format.html { redirect_to root_url}
        format.js { head :bad_request}
      end
    end
  end
end