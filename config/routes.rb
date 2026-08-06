Rails.application.routes.draw do
  # Redirect naked domain (medilinkapp.com) to www.medilinkapp.com
  constraints host: "medilinkapp.com" do
    match "(*any)" => redirect(subdomain: "www"), via: :all
  end

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :medications, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :calendar
    end
    resources :chats, only: [:create]
  end

  resources :chats, only: [:show, :destroy] do
    resources :messages, only: [:create]
  end

  resources :medications, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :medication_logs, only: [:create]
  end

  resources :follows, only: [:index, :create, :destroy]
  resources :notifications, only: [:index, :destroy] do
    collection do
      get :latest
    end
  end
  resource :profile, controller: "users", only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check

end
