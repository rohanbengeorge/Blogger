Rails.application.routes.draw do

  get 'home/index'
  devise_for :users
  resources :users do
    member do
      post 'assign_admin_status'
      post 'remove_admin_status'      
    end
    resources :posts
  end
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
