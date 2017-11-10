Rails.application.routes.draw do
  resources :contacts
  get 'favorites/create'

  get 'favorites/destroy'

  get 'sessions/new'

  root to: 'blogs#index'
  resources :sessions, only: %i[new create destroy]
  resources :users
  resources :favorites, only: %i[create destroy]
  # resources :blogs
  resources :blogs do
    collection do
      get :confirm
    end
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
