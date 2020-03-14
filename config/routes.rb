Rails.application.routes.draw do
  resources :tests

  root 'mypage#index'
  resources :items
  resources :purchases

end
