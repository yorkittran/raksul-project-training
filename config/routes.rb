# frozen_string_literal: true

Rails.application.routes.draw do
  resources :models do
    member do
      put 'restore'
    end
  end
  resources :phones
  resources :manufacturers
  resources :os_names
  resources :body_colors
  resources :memories
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
