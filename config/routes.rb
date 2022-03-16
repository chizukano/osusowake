Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cooking_sessions, only: %i[index show] do
    resources :reservations, only: %i[show]
  end
  namespace :user do
    resource :chef, only: %i[new create show]
  end
end
