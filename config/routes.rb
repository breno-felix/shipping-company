Rails.application.routes.draw do
  root to: 'home#index'
  resources :carriers, only: [:new, :create, :show]
end
