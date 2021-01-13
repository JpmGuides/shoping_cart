Rails.application.routes.draw do
  resources :orders, only: [:show, :update] do
    member do
      delete 'remove_item/:item_id', action: :remove_product
    end
  end
  resources :clients, only: [:show] do
    resources :orders, only: [:create] do
      collection do
        post :add_product
      end
    end
  end

  concern :api_base do
    resources :categories, only: [:create]
    resources :products, only: [:create, :destroy]
    resources :orders, only: [:create]
  end

  namespace :v1 do
    concerns :api_base
  end

  root 'application#root'
end
