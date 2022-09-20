Rails.application.routes.draw do
    resources :home do
      get :search, on: :collection, to: 'home#search', as: 'search'
    end

    devise_scope :user do
      authenticated :user do
        root 'home#index', as: :root
      end

      unauthenticated :user do
        root 'public#homepage', as: :unauthenticated_root
      end
    end

    devise_for :users


    resources :users, except: [:create, :index] do
      post :follow, on: :member
      post :unfollow, on: :member
    end

    resources :stories, except: [:edit, :update, :index]

    resources :posts, only: [:new, :create, :show, :destroy, :edit, :update] do
      post :like, on: :member, to: 'likes#create', as: 'like'
      delete :unlike, on: :member, to: 'likes#destroy', as: 'unlike'
      resources :comments, only: [:new, :create, :destroy], shallow: true
    end

    namespace :api do
      namespace :v1 do
        resources :users, only: [] do
          member do
            get :followers
          end
        end
        resources :stories, only: [:index, :show]
      end
    end
end
