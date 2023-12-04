Rails.application.routes.draw do
  devise_for :users
  root "home#about"
  get 'home/about'
  get 'search', to: 'search#index'
  resources :decks
  resources :flashcards 

  resources :decks do
    resources :review, only: [:show, :update, :destroy]
  end

  #resets the session when user hits "review" button
  get 'decks/:id/review_and_reset', to: 'decks#review_and_reset', as: 'review_and_reset'
  
  #duplicate deck
  get 'decks/:id/duplicate', to: 'decks#duplicate_deck', as: 'duplicate_deck'
end
