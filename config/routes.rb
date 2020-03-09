Rails.application.routes.draw do
  resources :tests
  root "items#index"
  resources :items, expect: :show
end
