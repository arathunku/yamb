Yamb::Application.routes.draw do
  root to: "pages#home"

  post '/auth/login'  => 'authorizations#login',  as: "login"
  post '/auth/logout' => 'authorizations#logout', as: "logout"
  post '/auth/optout' => 'authorizations#optout', as: "optout"



  namespace :settings do
    get    '/'           => 'settings#index'
    patch  '/username'   => 'settings#username'
    resources :posts

    #html&&css
    get '/html' => 'settings#html'
    patch '/html' => 'settings#html_update'
    get '/css' => 'settings#css'
    patch '/css' => 'settings#css_update'
  end

  get ':username', to: 'pages#view', as: :post
  get ':username/:id', to: 'pages#show', as: :get_post

end
