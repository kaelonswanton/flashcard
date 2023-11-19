Rails.application.routes.draw do
  resources :decks
  resources :flashcards
  
  get '/decks/:id/review', to: 'flashcards#review', as: 'decks_review'
 


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
