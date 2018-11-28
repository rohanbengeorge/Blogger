# frozen_string_literal: true

Rails.application.routes.draw do
  get 'search/index'
  get 'home/index'
  get 'home/personal_feeds'
  get 'home/all_public_feeds'
  get 'home/all_feeds'
  get 'tags/:tag', to: 'home#tagged_feeds', as: :tag
  resources :likes, only: [:destroy, :create]
  devise_for :users
  resources :users do
    member do
      post 'assign_admin_status'
      post 'remove_admin_status'
      post 'ban_user'
    end
    resources :posts do
      resources :comments
    end
    member do
      get :following, :followers
    end
    resources :relationships, only: [:destroy, :create]
  end
  root 'home#index'
  # match '*path' => redirect('/'), via: :get
end
