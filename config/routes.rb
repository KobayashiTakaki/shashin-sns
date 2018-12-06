Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#home'

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
    get 'signup', to: 'devise/registrations#new'
  end

  get '/accounts/edit', to: 'users#edit'

  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  patch '/accounts/edit', to: 'users#update'

  post '/articles/like', to: 'likes#create'
  post '/articles/unlike', to: 'likes#destroy'

  get '/articles/liked_by', to: 'users#index_liked_to_article'

  resources :users, only: [:index, :create, :update, :destroy]
  resources :articles, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :articles do
    member do
      get :comments
    end
  end

  get '/:user_name', to: 'users#show'

end
