Rails.application.routes.draw do

  root 'top#index'

  get 'signup' => 'users#new'
  resources :users, except: [:new]
  resources :articles

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :categories, except: [:destroy]

  get "my_friends" => "users#my_friends"
  resources :friendships
  post "add_friend" => "users#add_friend"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
