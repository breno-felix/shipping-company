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
    resources :order_services, only: [:new, :create, :edit, :update] do
      patch :accepted, on: :member
      patch :refused, on: :member 
      
    end
    resources :update_order_services, only: [:index, :new, :create] do
      get 'search', on: :collection
    end
    
  end
  resources :order_services, only: [:index]
end