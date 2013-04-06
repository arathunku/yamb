class Settings::PostsController < Settings::SettingsController

  def index
    @posts = current_user.posts.load || []
  end
  
  def new
    @post = Post.new

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
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(content: params[:post])
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
