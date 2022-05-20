Rails.application.routes.draw do
  root to: 'home#index'
  resources :carriers, only: [:new, :create, :show] do
    resources :prices, only: [:new, :create, :show]
    resources :volumes, only: [:new, :create]
  end
end