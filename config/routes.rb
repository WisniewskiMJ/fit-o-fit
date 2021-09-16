Rails.application.routes.draw do
  root 'users#dashboard'

  devise_for :users

  resources :users, only: [:show]

  resources :activities, only: [:index, :new, :create, :show, :destroy]
end