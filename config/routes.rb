Yamb::Application.routes.draw do
  root to: "pages#home"

  post '/auth/login'  => 'authorizations#login',  as: "login"
  post '/auth/logout' => 'authorizations#logout', as: "logout"
  post '/auth/optout' => 'authorizations#optout', as: "optout"



  namespace :settings do
    get    '/'           => 'settings#index'
    patch  '/username'   => 'settings#username'
    resources :posts
  end


end
