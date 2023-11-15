Rails.application.routes.draw do
  get 'review/index'
  get 'cards/new'
  resources :decks
  resources :flashcards

  devise_for :users
  get 'home/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#about"

end
