Rails.application.routes.draw do
  resources :home, only: [:index]
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :root
    end

    unauthenticated :user do
      root 'public#homepage', as: :unauthenticated_root
    end
  end

  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :stories, only: [:new, :create, :show, :destroy]
  resources :posts, only: [:new, :create, :show, :destroy, :edit] do
    resources :comments, only: [:new, :create, :show, :destroy], shallow: true
    # resources :likes, only: [:create], as: "like_post", shallow: true
    # members do
    #   put 'like' => 'posts#like'
    # end
  end
  # resources :likes
  post '/posts/:id/like', to: "likes#create", as: "like_post"
  delete '/posts/:id/unlike', to: "likes#destroy", as: "unlike_post"

  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  # resources :follows
  # post 'follow/user', to: 'users#follow_account', as: :follow_account
  # get '/follows/:id', to: 'follows#show', as: 'follows'
  # post '/follow/:id', to: 'follows#create', as: 'follow'
  # delete '/unfollow/:id', to: 'follows#destroy', as: 'unfollow'
  # delete '/comments/:id', to: 'comments#destroy'

  # resources :comments, only: [:index, :create, :destroy], shallow: true
  # , shallow: true do
  #   resources :photos
  #   resources :comments
  #   # , shallow: true
  #   # resources :likes, shallow: true
  #   # resources :stories, ,: true``
  # end
  # # path: '',
  # path_names: {sign_in}
  # resources :users
  # devise_scope :user do
  #   # authenticated :user do
  #   root :to => "devise/sessions#new"
  # end
  # , only: [:index,]

  # devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
