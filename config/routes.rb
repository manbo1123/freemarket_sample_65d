Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
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

  root 'items#index'
  # resources :toppage, only: [:index, :show]
  resources :mypage, only: [:index]

  
  resources :items
  resources :purchases

  resources :cards, only: [:index, :new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
end
