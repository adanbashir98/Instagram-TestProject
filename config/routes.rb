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
  resources :users, only: [:show, :edit, :update] do
   post :follow, on: :member
   post :unfollow, on: :member
  end
  resources :stories, only: [:new, :create, :show, :destroy]
  resources :posts, only: [:new, :create, :show, :destroy, :edit] do
    post :like, on: :member
    delete :unlike, on: :member
    resources :comments, only: [:new, :create, :show, :destroy], shallow: true
  end

  # post '/posts/:id/like', to: "likes#create", as: "like_post"
  # delete '/posts/:id/unlike', to: "likes#destroy", as: "unlike_post"

  # post '/users/:id/follow', to: "users#follow", as: "follow_user"
  # post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  # devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
