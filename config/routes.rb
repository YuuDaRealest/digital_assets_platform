Rails.application.routes.draw do
  resources :purchase_items
  resources :purchases
  resources :customers
  resources :digital_assets do
    collection do
      post :bulk_import
    end
    member do
      get :download
    end
  end
  resources :creators

  # Admin API routes
  namespace :api do
    namespace :admin do
      post 'auth/login', to: 'auth#login'
      delete 'auth/logout', to: 'auth#logout'
      resources :earnings, only: [:index]
    end
  end
end
