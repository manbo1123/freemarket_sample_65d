Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
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

  root 'items#index'

  namespace :api do
    resources :items, only: :index, defaults: { format: 'json' }
  end

  resources :mypage, only: [:index] do
    collection do
      delete 'logout' 
    end
  end

  namespace :mypage do
    get 'exhibition/selling', to: 'exhibition#index'
    get 'exhibition/dealing', to: 'exhibition#index'
    get 'exhibition/closed', to: 'exhibition#index'
    get 'exhibition/set_exhibition', defaults: { format: 'json' }
    post 'exhibition/shipping'
    get 'purchases/dealing', to: 'purchases#index'
    get 'purchases/closed', to: 'purchases#index'
    get 'purchases/index', to: 'mypage/purchases#index'
    get 'purchases/set_purchase', defaults: { format: 'json' }
    post 'purchases/arriving'
    get 'sending_destinations/edit'
    patch 'sending_destinations/update'
    get 'cards/show'
    post 'cards/delete'
    get 'cards/index'
    get 'cards/new'
    post 'cards/pay'
    get 'accounts/edit'
    patch 'accounts/update'
    get 'passwords/edit_password', to: 'accounts#edit_password'
    patch 'passwords/update_password', to: 'accounts#update_password'
    get 'favorites/index', to:'favorites#index'
  end

  resources :items, only: [:new, :create, :show, :destroy, :edit, :update] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'purchase', to: 'items#purchase'
      post 'buy', to: 'items#buy'
    end
    resources :comments, only: [:create,:destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :cards, only: [:index, :new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
end

