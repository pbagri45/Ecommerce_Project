Rails.application.routes.draw do
  # Devise routes
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  # ActiveAdmin routes
  ActiveAdmin.routes(self)
  
  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check
  
  # PWA routes
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
  
  # Static pages
  get "pages/home"
  get "pages/about"
  get "pages/contact"

  # Products and cart routes
  resources :products, only: [:index, :show] do
    post 'add_to_cart', on: :member
  end
  resource :cart, only: [:show, :update, :destroy]

  # Orders and checkout
  resources :orders, only: [:new, :create, :show, :index]
  post 'checkout', to: 'checkouts#create'

  # Admin namespace
  namespace :admin do
    resources :products
    resources :orders, only: [:index, :show, :update]
  end

  # Define root path (update this as per your app's main page)
  root "pages#home"
end
