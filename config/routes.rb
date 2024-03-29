# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  namespace :api do
    get "/users_by_email" => "users_by_emails#show", as: :users_by_email

    resources :favourites, only: %i[create destroy]
  end

  get "/properties/search" => "properties/search#index"

  resources :properties, only: :show do
    resources :reservations, only: :new, controller: "properties/reservations"
  end

  resources :reservation_payments, only: :create

  resources :profiles, only: %i[show update]

  resources :accounts, only: %i[show update]

  resources :passwords, only: %i[show update]

  resources :payments, only: :index

  put "/hostify/:user_id" => "hostify#update", as: :hostify

  namespace :host do
    get "/dashboard" => "dashboard#index", as: :dashboard

    resources :properties, only: %i[new create]

    resources :payments, only: :index
  end
end
