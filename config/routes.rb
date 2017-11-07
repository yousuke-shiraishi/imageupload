Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  get 'sessions/new'

  root to: "blogs#index"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :blogs
  resources :favorites, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
