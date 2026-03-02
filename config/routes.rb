Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  get "dashboard", to: "home#dashboard"

  resources :users
  resources :categories

  get "up" => "rails/health#show", as: :rails_health_check
end
