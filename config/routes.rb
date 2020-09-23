# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|vi/ do
    resources :models do
      member do
        put 'restore'
      end
    end
    resources :inventories do
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
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
