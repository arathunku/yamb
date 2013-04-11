class PagesController < ApplicationController
  def home
  end


  #refactor extract making a hash for displaying post
  def view
    user = User.find_by(username: params[:username])
    if user
      html = user.design.html || ""
      css = user.design.css
      varibles = {css: css, author: user.email, postTitle: "posts"}
      @result = Mustache.render(html, varibles)
      render layout: false
    else 
      render_404
    end
  end

  def show
    user = User.find_by(username: params[:username])
    if user
      post = Post.find_by(id: params[:id])
      #render_404 unless post
      html = user.design.html || ""
      css = user.design.css
      varibles = {css: css, author: user.email, postTitle: "posts"}
      @result = Mustache.render(html, varibles)
      render 'view', layout: false
    else 
      render_404
    end
  end 
end