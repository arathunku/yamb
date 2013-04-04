require 'spec_helper'

describe Settings::SettingsController do
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

  it "update username" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    new_username = "ijsaijdsaad"
    put 'username', username: new_username
    user = User.find(user.id)
    user.username.should eq(new_username)
  end
end
