Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  get 'sessions/new'

  root to: "blogs#index"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
  # resources :blogs
  resources :blogs do
    collection do
      get :confirm
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
