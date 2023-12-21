Rails.application.routes.draw do
  namespace :decks do
    resources :shared_decks, only: [:index, :update]
  end

  namespace :flashcards do
    resources :searches, only: [:index]
  end

  namespace :decks do
    resources :searches, only: [:index]
  end
  resources :decks do
    resources :reviews, only: [:show, :update, :destroy]
    resources :votes, only: [:create]
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root "home#about"
  get 'home/about'
  get 'search', to: 'search#index'
  resources :flashcards 
  resources :users, only: [:show]

  #resets the session when user hits "review" button
  get 'decks/:id/review_and_reset', to: 'decks#review_and_reset', as: 'review_and_reset'
  
  #duplicate deck
  post 'decks/:id/duplicate', to: 'decks#duplicate_deck', as: 'duplicate_deck'
end
