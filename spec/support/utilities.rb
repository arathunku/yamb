
module Utilities
  def sign_in(user)
    cookies[:remember_token] = user.remember_token
  end

  def log_in(u=nil)
    user = u || FactoryGirl.create(:user)
    sign_in(user)
    user
  end
end