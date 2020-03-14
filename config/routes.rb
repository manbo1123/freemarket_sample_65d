Rails.application.routes.draw do
  root 'items#index'
  resources :items
  resources :tests
  resources :purchases

  root "items#index"
  resources :mypage
  
  resources :items, expect: :show
end
