Rails.application.routes.draw do
  root 'items#index'
  resources :items
  resources :tests
  resources :purchases

  root "mypage#index"
  resources :mypage
  
  resources :items, expect: :show
end
