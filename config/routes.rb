Rails.application.routes.draw do
  get 'search', to: 'search#index'
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
    post :like, on: :member, to: "likes#create", as: "like"
    delete :unlike, on: :member, to: "likes#destroy", as: "unlike"
    resources :comments, only: [:new, :create, :show, :destroy], shallow: true
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
