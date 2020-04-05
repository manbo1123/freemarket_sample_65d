Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  resources :signup do
    collection do
      get 'index'
    end
  end
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#new_sending_destination'
    post 'sending_destinations', to: 'users/registrations#create_sending_destination'
  end

  root 'toppage#index'
  resources :toppage, only: [:index, :show]
  namespace :api do
    resources :toppage, only: :index, defaults: { format: 'json' }
  end

  resources :mypage, only: [:index] do
    collection do
      get 'logout' 
    end
  end
  # namespace :mypage do
  #   resources :sending_destination, only: [:edit, :update]
  # end

  namespace :mypage do
    get 'sending_destinations/edit'
    patch 'sending_destinations/update'
  end

  
  resources :items
  resources :purchases

  resources :cards, only: [:index, :new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
      post 'buy', to: 'cards#buy'
    end
  end
end
