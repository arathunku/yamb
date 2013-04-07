require 'spec_helper'

describe Settings::PostsController do
  it "redirect if not logged it" do
    get :index
    response.should redirect_to(root_path)
  end
  describe do
    before(:each) {
      @user = log_in
    }
    describe "index" do
      #pending "show return varible with all posts"
      before(:each) do
        get :index
      end
      it { response.should be_successful}
    end
    
    describe "new" do
      before(:each) do
        get :new
      end
      it { response.should be_successful }
    end
    
    describe "create" do
      describe "correct post" do
        before(:each) {
          #the p is only temporary, it's easier to use model
          #to parse everything
          @entry = FactoryGirl.build(:post, user: @user)
          @count = Post.all.length
          post :create, post: { 
            content: File.read('spec/post_data/1.mdown')}
        }
        it do
         response.should redirect_to("/settings/posts/#{@count+1}/edit")
        end
        it { Post.all.length.should eq(@count+1) }
      end
    end

    describe "edit" do
      before(:each) {
        @post = FactoryGirl.create(:post, user: @user)
        get :edit, id: @post.id
      }
      it { response.should be_successful }
    end

    describe "update" do
      before(:each) {
        @post = FactoryGirl.create(:post, user: @user)
      }
      it do
        put :update, id: @post.id,
          post: { content: File.read('spec/post_data/1.mdown')}
        response.should redirect_to("/settings/posts/#{@post.id}/edit")
      end
      it "title of a post" do
        put :update, id: @post.id, 
          post: { content: File.read('spec/post_data/1_title.mdown') }
        post = Post.find(@post.id)
        post.title.should_not eq(@post.title)
      end
    end

    describe "destroy" do
      before(:each) {
        @post = FactoryGirl.create(:post, user: @user)
      }
      it "post" do
        delete :destroy, id: @post.id
        response.should redirect_to(settings_posts_path)
      end
      it "change posts count" do
        expect {delete :destroy, id: @post.id}.to \
          change(Post, :count).by(-1)
      end
    end
  end
end
