Rails.application.routes.draw do
  devise_for :users
  root to: 'question#index'
  # resources :question, only: [:index]
  resources :qfile, only: [:index, :new, :create]
  # index
  # start
  # countdown
  # game
  # result
  # lanking
  # devise-signin
  # devise-login
end
