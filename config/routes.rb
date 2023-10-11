Rails.application.routes.draw do
  devise_for :users
  resources :listings
  resources :bookings
  resources :reviews, only: [:new, :create]
  root "pages#index"
  
end
