Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


  # Routes for gemstones: index, show, create, update, destroy
  resources :gemstones, except: [:new]

  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/daily', to: 'pages#daily'
  get '/random', to: 'pages#random'

  # Root
  root 'pages#home'

  #game
  resources :games, only: [:index, :show, :create, :update, :destroy]
  
end
