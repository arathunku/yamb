module AuthorizationsHelper
  require 'net/http'
  def authenticate_with_persona(params)
    #TODO:
    # *handle if provider won't respond
    assertion = params[:assertion]
    audience = params[:audience]
    http = Net::HTTP.new('verifier.login.persona.org', 443)
    http.use_ssl = true
    headers = {
     'Content-Type' => 'application/x-www-form-urlencoded',
    }
    data = "audience=#{audience}&assertion=#{assertion}"
    if Rails.env.production? || Rails.env.development?
      resp = http.post("/verify",data,headers)
      JSON.parse(resp.body())
    else 
      { "status"=> "okay",
        "email"=> "example@example.com",
        "audience"=> "https://localhost.com:80",
        "expires"=> 1308859352261,
        "issuer"=> "example.com" }
    end
  end


  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
