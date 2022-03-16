Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cooking_sessions, only: %i[index show]

  namespace :user do
    resource :chef, only: %i[new create show] do
      resource :meal, only: %i[new create]
      resource :cooking_session, only: %i[new create]
    end
  end
end
