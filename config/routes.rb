Rails.application.routes.draw do
  root 'static_pages#home'

  get '/login', to: 'sessions#new'
  get '/signup', to: 'users#new'
  get '/accounts/edit', to: 'users#edit'

  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  patch '/accounts/edit', to: 'users#update'

  post '/posts/like', to: 'likes#create'
  post '/posts/unlike', to: 'likes#destroy'

  get '/posts/liked_by', to: 'users#index_liked_to_post'

  resources :users, only: [:index, :create, :update, :destroy]
  resources :posts, only: [:new, :create, :show, :edit, :update, :destroy]

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
# POST /posts/:id/comment => Comments#create
# POST /posts/:id/like => Likes#create
#
#
# GET /:user_name => Users#show
