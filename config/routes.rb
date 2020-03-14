Rails.application.routes.draw do
  resources :tests

  root "items#index"
  resources :mypage
  
  resources :items, expect: :show
end
