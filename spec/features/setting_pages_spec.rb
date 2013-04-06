require 'spec_helper'


describe "Settings" do
  describe "GET settings/posts" do
    before(:each) do 
      @user = FactoryGirl.build(:user)
      #post login_path, assertion: {email: @user.email}
      @post = FactoryGirl.build(:post, user: @user)
    end
    it "display posts titles" do
      post login_path, assertion: {email: @user.email}
      #get hit index and works correclty but unfortunetly does 
      #not render view here. Visit however does not pass method
      #:someone_logged_in? because current_user is nil.
      @post.save
      #visit '/settings/posts'
      #page.should have_content(@post.title)
      get '/settings/posts'
      response.should have_content(@post.title)
    end
  end

end