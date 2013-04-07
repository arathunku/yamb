require 'spec_helper'

describe PagesController do
  before(:each) {
    @user = log_in
    @user.change_username("arathunku")
  }

  it "display front user page" do
    get :view, username: "arathunku"
    response.response_code.should == 200
  end

  render_views
  it "properly render view" do
    @user.design.update_code(:html, "posts {{css}}")
    @user.design.update_code(:css, "* { font-size: 100px; }")
    get :view, username: "arathunku"
    response.body.should have_content("posts")
  end

end