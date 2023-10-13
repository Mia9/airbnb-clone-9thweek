Rails.application.routes.draw do
  devise_for :users
  resources :listings
  resources :bookings
  resources :reviews, only: [:new, :create]
  resources :users, only: [:show, :edit, :destroy]
  root "pages#index"
  
  post "/users/:id", to: "users#show", as: "show_user"
end
