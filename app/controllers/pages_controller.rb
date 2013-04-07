class PagesController < ApplicationController
  def home
  end

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

end