Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions do
    member do
      get 'play'
    end
  end
  # resources :users, only: [:edit, :update]
end
