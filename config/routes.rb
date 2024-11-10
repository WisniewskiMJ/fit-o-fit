Rails.application.routes.draw do
  root 'pages#welcome'

  devise_for :users

  get '/dashboard', to: 'pages#dashboard'

  resources :users, only: %i[show dashboard]

  resources :activities, only: %i[index new create show destroy]
end
