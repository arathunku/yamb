require 'spec_helper'

describe SettingsController do
  describe "show if logged in" do
    before(:each) {
      log_in
    }
    it { response.should be_success }
  end

  describe "redirect to root if notlogged in" do
    before(:each) {
      get :index
    }
    it { response.should redirect_to(root_path) }
  end
end
