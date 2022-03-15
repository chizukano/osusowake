Rails.application.routes.draw do
  resources :cooking_sessions, only: [:show]

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cooking_sessions, only: %i[index]
end
