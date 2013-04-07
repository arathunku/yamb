class Settings::PostsController < Settings::SettingsController

  def index
    @posts = current_user.posts.load || []
  end
  
  def new
    value = "Title: \nStatus: public\nExcerpt: \n\n\n"
    @post = Post.new(content: value)
  end

  def create
    @post = current_user.posts.new(content: params[:post][:content])
    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_settings_post_path(@post) }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @post.content = @post.merge_content
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(content: params[:post][:content])
        format.html { redirect_to edit_settings_post_path(@post)}
      else
        format.html { render :action => 'edit'}
      end
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to settings_posts_path
  end
end
