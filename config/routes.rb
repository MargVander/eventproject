Rails.application.routes.draw do
  get 'pictures/create'
  devise_for :users
  resources :events do
    resources :participations
    resources :pictures
  end
  resources :users do
    resources :avatars, only: [:create]
  end
  root 'events#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
