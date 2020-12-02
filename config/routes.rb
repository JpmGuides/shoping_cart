Rails.application.routes.draw do
  concern :api_base do
    resources :categories, only: [:create]
    resources :products, only: [:create, :destroy]
  end

  namespace :v1 do
    concerns :api_base
  end
end
