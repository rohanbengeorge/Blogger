# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  resources :users do
    member do
      post 'assign_admin_status'
      post 'remove_admin_status'
      post 'ban_user'
    end
    resources :posts do
      resources :comment
    end
  end
  root 'home#index'
end
