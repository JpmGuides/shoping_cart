Rails.application.routes.draw do
  resources :orders, only: [:show]

  concern :api_base do
    resources :categories, only: [:create]
    resources :products, only: [:create, :destroy]
  end

  namespace :v1 do
    concerns :api_base
  end
end
