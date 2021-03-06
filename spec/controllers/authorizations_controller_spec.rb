require 'spec_helper'

describe AuthorizationsController do
  describe "log in" do
    describe "should return 400" do
      before(:each){
        post 'login'
      }
      it do 
        response.should_not be_success
      end
      it "and flash warning" do
        flash[:warning].should_not be_nil
      end
    end

    describe "should return ok" do
      before(:each) {
        post 'login', assertion: {email: "example@example.com"}
      }
      it do
        response.should redirect_to(settings_url)
      end
      it "and flash success" do
        flash[:success].should_not be_nil
      end
      it "and cookie should not be nil" do
        cookies[:remember_token].should_not be_nil
      end
    end
  end
  describe "should redirect to settings" do
    before(:each) {
      FactoryGirl.build(:user).save
    }
    it do
      post 'login', assertion: {email: "example@example.com"}
      response.should redirect_to(settings_url)
    end
  end
  describe "logout" do
    before(:each) {
      post 'logout'
    }
    it "should flash message" do
      flash[:notice].should_not be_nil
    end
    it "should clean cookie" do
      cookies[:remember_token].should be_nil
    end
  end

  describe "destroy" do
    before(:each) {
      log_in
    }
    it "user correctly" do
      expect { post 'optout'}.to change(User, :count).by(-1)
    end
  end
end
