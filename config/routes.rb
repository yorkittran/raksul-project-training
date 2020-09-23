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

  # exclude active_storage route from routing error
  get '*path', to: 'error#catch_routing_error', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
