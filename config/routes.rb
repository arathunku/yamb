Yamb::Application.routes.draw do
  root to: "pages#home"

  match '/auth/login' => 'authorizations#login', as: "login", via: 'post'
  match '/auth/logout' => 'authorizations#logout', as: "logout", via: 'post'
  match '/auth/optout' => 'authorizations#optout', as: "optout", via: 'post'
  resources :settings, only: [:index] do
  end

end
