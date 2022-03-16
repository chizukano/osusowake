Rails.application.routes.draw do
  # cooking_sessions/:cooking_session_id/...
  resources :cooking_sessions, only: [:show, :new] do
    # .../reservations
    resources :reservations, only: [:create, :show]
  end
  # reservations/:id
  resources :reservations, only: [:show]

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cooking_sessions, only: %i[index]
end
