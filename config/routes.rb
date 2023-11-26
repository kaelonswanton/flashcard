Rails.application.routes.draw do
  devise_for :users
  root "home#about"
  get 'home/about'
  resources :decks
  resources :flashcards 

  resources :decks do
    resources :review, only: [:show, :update, :destroy]
  end

end
