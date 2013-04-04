Yamb::Application.routes.draw do
  root to: "pages#home"

  post   '/auth/login'  => 'authorizations#login', as: "login"
  post   '/auth/logout' => 'authorizations#logout', as: "logout"
  post   '/auth/optout' => 'authorizations#optout', as: "optout"



  #posts
  namespace :settings do
    get    '/'           => 'settings#index'
    put    '/username'  => 'settings#username'
    resources :posts
  end
  # get    'settings/posts/'    => 'posts#index'
  # post   'settings/posts/new' => 'posts#create'
  # get    'settings/posts/:id/edit' => 'posts#edit', as: 'settings_posts_edit'
  # put    'settings/posts/:id' => 'posts#update'
  # delete 'settings/posts/:id' => 'posts#destroy'

end
