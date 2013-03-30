
module Utilities
  def sign_in(user)
    cookies[:remember_token] = user.remember_token
  end

  def log_in
    user = FactoryGirl.create(:user)
    sign_in(user)
  end
end