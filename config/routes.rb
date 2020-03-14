Rails.application.routes.draw do
  resources :tests

  root "mypage#index"
  resources :mypage
  
  resources :items, expect: :show
end
