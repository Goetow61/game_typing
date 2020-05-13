Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'questions#index'
  
  resources :questions do
    member do
      get 'play'
      post 'result', defaults: { format: 'json' }
    end
  end
  
  resources :rankings
end
