require 'spec_helper'

describe User do
  describe "FactoryGirl" do
    it "should be valid" do
      FactoryGirl.build(:user).should be_valid
    end
  end
  describe "should ACCEPT" do
    it "username" do
      FactoryGirl.build(:user, username: "example").should be_valid
    end
  end

  describe "should REJECT" do
    it "username too long" do
      FactoryGirl.build(:user, username: "a"*129).should_not be_valid
    end
  end

  it "default username" do
    #debugger
    user = FactoryGirl.create(:user)
    user.username.should eq(user.id)
  end

  describe "change_username" do
    it "for nil don't change anything" do
      user = FactoryGirl.build(:user)
      old_username = user.username
      new_username = nil
      user.change_username(new_username)
      user.username.should eq(old_username)
    end
    it "change username" do
      user = FactoryGirl.build(:user)
      new_username = "xxxx"
      user.change_username(new_username)
      user.username.should eq(new_username)
    end
  end

end
