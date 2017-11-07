Rails.application.routes.draw do
  get 'sessions/new'

  root to: "blogs#index"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :blogs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
