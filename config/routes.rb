Rails.application.routes.draw do
  root 'pages#welcome'

  devise_for :users

  get '/dashboard', to: 'pages#dashboard'

  resources :users, only: [:show, :dashboard]

  resources :activities, only: [:index, :new, :create, :show, :destroy]
end