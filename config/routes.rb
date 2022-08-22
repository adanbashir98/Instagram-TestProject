Rails.application.routes.draw do
  resources :home, only: [:index]
  devise_scope :user do
    # authenticated :user do
    root :to => "devise/sessions#new"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
