Rails.application.routes.draw do
  root 'static_pages#home'

  get '/login', to: 'sessions#new'
  get '/signup', to: 'users#new'

  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  resources :users


end

# GET / => static_pages#home
# GET /users/new => User#new
# POST /users/new => User#create
#
# GET /login => Sessions#new
# POST /login => Sessions#create
# POST /logout => Sessions#destroy
#
# GET /posts/:id => Posts#show
# GET /posts/new => Posts#new
# POST /posts => Posts#create
# POST /posts/:id/comment => Posts#comment
# POST /posts/:id/like => Posts#like
#
#
# GET /:user_name => Users#show
