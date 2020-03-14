Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root to: "home#index" #ログイン機能確認用（仮）

  resources :signup do
    collection do
      get 'index'
      get 'done' 
    end
  end

  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#new_sending_destination'
    post 'sending_destinations', to: 'users/registrations#create_sending_destination'
  end
  resources :tests

  root 'mypage#index'
  resources :items
  resources :purchases

end

  
