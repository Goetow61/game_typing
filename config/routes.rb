Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions, only: [:index, :new, :create, :show]
  resources :users, only: [:edit, :update]
end
