require 'spec_helper'

describe Design do
  before(:each) { @user = FactoryGirl.create(:user) }
  
  it "update html column" do
    old_column = @user.design.html
    @user.design.update_code(:html, "code")
    User.find(@user.id).design.html.should_not eq(old_column)
  end

  it "update css column" do
    old_column = @user.design.css
    @user.design.update_code(:css, "css")
    User.find(@user.id).design.css.should_not eq(old_column)
  end

end