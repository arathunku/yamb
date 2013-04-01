Yamb::Application.routes.draw do
  root to: "pages#home"

  post '/auth/login' => 'authorizations#login', as: "login"
  post '/auth/logout' => 'authorizations#logout', as: "logout"
  post '/auth/optout' => 'authorizations#optout', as: "optout"


  get 'settings' => 'settings#index'
  put 'settings/username' => 'settings#username'
end
