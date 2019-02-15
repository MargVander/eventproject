Rails.application.routes.draw do
  devise_for :users
  resources :events do
    resources :participations
  end
  resources :users do
    resources :avatars, only: [:create]
  end
  namespace :admin do
    root 'admin#index'
    resources :users, :events
  end
  root 'events#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
