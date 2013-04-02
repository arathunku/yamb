Yamb::Application.routes.draw do
  root to: "pages#home"

  post   '/auth/login'  => 'authorizations#login', as: "login"
  post   '/auth/logout' => 'authorizations#logout', as: "logout"
  post   '/auth/optout' => 'authorizations#optout', as: "optout"


  get    'settings'           => 'settings#index'
  put    'settings/username'  => 'settings#username'

  #posts
  get    'settings/posts/'    => 'posts#index'
  post   'settings/posts/new' => 'posts#create'
  get    'settings/posts/:id' => 'posts#edit'
  put    'settings/posts/:id' => 'posts#update'
  delete 'settings/posts/:id' => 'posts#destroy'

end
