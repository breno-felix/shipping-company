Rails.application.routes.draw do
  root to: 'home#index'
  resources :carriers, only: [:new, :create, :show] do
    patch :disabled, on: :member
    patch :enabled, on: :member
    get 'budget', on: :collection
    resources :prices, only: [:index]
    resources :volumes, only: [:new, :create]
    resources :weights, only: [:new, :create]
    resources :kilometers, only: [:new, :create]
    resources :deadlines, only: [:index, :new, :create]
    resources :vehicles, only: [:index, :new, :create]
  end
end