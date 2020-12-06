Rails.application.routes.draw do
  resources :orders, only: [:show, :update]

  concern :api_base do
    resources :categories, only: [:create]
    resources :products, only: [:create, :destroy]
    resources :orders, only: [:create]
  end

  namespace :v1 do
    concerns :api_base
  end
end
