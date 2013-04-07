require 'spec_helper'

describe Post do
  before(:each) {
    @user = FactoryGirl.create(:user)
  }
  #tests use 1.mdown
  it "adding a valid post" do
    FactoryGirl.build(:post, user: @user).should be_valid
  end
  describe "add post " do
    it "and return default title" do
      post = FactoryGirl.create(:post, user: @user)
      post = Post.find(post.id)
      post.title.should eq("Nesta - CMS")
    end

    it "status draft if not specified" do
      post = FactoryGirl.create(:post, user: @user)
      post = Post.find(post.id)
      post.status.should eq("draft")
    end

    it "parse metadata correctly" do
      post = FactoryGirl.create(:post, user: @user)
      post = Post.find(post.id)
      post.metadata_key('tags').should_not be_nil
    end
  end
end
