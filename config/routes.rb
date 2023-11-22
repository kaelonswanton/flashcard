Rails.application.routes.draw do
  resources :decks
  resources :flashcards
  resources :review 
  get '/decks/:id/review', to: 'review#index', as: 'decks_review'
  post '/decks/:id/review', to: 'review#update'


  devise_for :users
  get 'home/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#about"

  # resources :flashcards do
  #   member do
  #     patch 'update_difficulty'
  #   end
  # end

end
