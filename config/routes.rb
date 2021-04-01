Rails.application.routes.draw do
  resources :orders, only: [:show, :update] do
    member do
      delete 'remove_item/:item_id', action: :remove_product
      get 'payment_success', action: :payment_success
      get 'payment_fail', action: :payment_fail
    end
  end
  resources :clients, only: [:show] do
    get :general_conditions
    resources :orders, only: [:create] do
      collection do
        post :add_product
      end
    end
    get 'categories/:category_id', action: 'show'
  end

  concern :api_base do
    resource :clients, only: [:update]
    resources :categories, only: [:create]
    resources :products, only: [:create, :destroy]
    resources :orders, only: [:create]
  end

  namespace :v1 do
    concerns :api_base
  end

  root 'application#root'
end
