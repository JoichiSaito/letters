Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index'

  devise_for :users

  resources :users do
    get :follows, on: :member
    get :followers, on: :member
    resource :relationships, only: %i[create destroy]

    resource :requests, only: %i[show create destroy]
    resource :answers, only: %i[create destroy]
  end

  resources :boards do
    resource :joins, only: %i[show create destroy]
  end
end
