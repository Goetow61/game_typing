Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  # resources :question, only: [:index]
  resources :questions, only: [:index, :new, :create]
  resources :users, only: [:edit, :update]
  # index
  # start
  # countdown
  # game
  # result
  # lanking
  # devise-signin
  # devise-login
end
