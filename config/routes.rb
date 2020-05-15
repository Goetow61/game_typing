Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: 'questions#index'

  resources :questions do
    member do
      get 'play'
      post 'result', defaults: { format: 'json' }
    end
  end
  
  resources :rankings
end
