class PostsController < ApplicationController
  before_filter :someone_logged_in?

  def show
    @posts = current_user.post.all
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save

    else

    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    #update
    @post = Post.find(params[:id])
    #errors handle
    @post.update_attributes(params[:post])
  end

  def destroy
    Posts.find(params[:id]).destroy
  end
end
