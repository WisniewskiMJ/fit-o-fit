Rails.application.routes.draw do
  root 'users#dashboard'

  devise_for :users

  resources :activities, only: [:new, :create, :show, :destroy]
end