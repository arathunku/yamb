require 'spec_helper'

describe Settings::SettingsController do
  describe "redirect to root if notlogged in" do
    before(:each) {
      get :index
    }
    it { response.should redirect_to(root_path) }
  end

  describe "show if logged in" do
    before(:each) {
      @user = log_in
    }
    it { response.should be_success }

    it "update username" do
      new_username = "ijsaijdsaad"
      put 'username', user: { username: new_username }
      user = User.find(@user.id)
      user.username.should eq(new_username)
    end

    it "GET html edit page" do
      get 'html'
      response.response_code.should == 200
    end

    it "patch html" do
      post 'html_update', design: { html: "<div>tekst</div>"}
      response.response_code.should == 302
    end
  end
  
end
