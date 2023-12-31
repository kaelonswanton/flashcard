class DecksController < ApplicationController
  before_action :authenticate_user!

  def index
    @deck = current_user.decks.build #for model error
    @pagy, @decks = pagy(current_user.decks.all, items: 5)
  end

  def show
    @deck = Deck.find(params[:id])
    @pagy, @flashcards = pagy(@deck.flashcards, items: 5)
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user_id = current_user.id

    if @deck.save
      flash[:message] = "Deck created successfully!"
      redirect_to decks_path
    else
      @decks = current_user.decks
      @pagy, @decks = pagy(@current_user.decks.all, items: 5)  
      render 'index', status: :unprocessable_entity
    end
  end

  def edit
    @deck = current_user.decks.find(params[:id])
    @pagy, @decks = pagy(@current_user.decks.all, items: 5)
  end

  def update
    @deck = current_user.decks.find(params[:id])

    if @deck.update(deck_params)
      flash[:message] = "Deck updated successfully!"
      redirect_to decks_path
    else
      @decks = current_user.decks
      @pagy, @decks = pagy(@current_user.decks.all, items: 5)  
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    decks = current_user.decks
    deck = current_user.decks.find(params[:id])
    deck.destroy
    flash[:message] = "Deck deleted successfully!"
    redirect_to decks_path
  end

  # Deck Review
  def review_and_reset
    session.delete(:fetched_flashcards)
    redirect_to deck_review_path(params[:id], id: 0)
  end

  # Deck Duplicate
  def duplicate_deck
    original_deck = Deck.find(params[:id])
    new_deck = original_deck.dup
    new_deck.user = current_user
    new_deck.shared = false #keep decks auto unshared

    if new_deck.save
      original_deck.flashcards.each do |flashcard|
        new_flashcard = flashcard.dup
        new_flashcard.deck = new_deck
        new_flashcard.difficulty = 4.0
        new_flashcard.save
      end
      flash[:message] = "Deck duplicated successfully!"
      redirect_to decks_path
    else
      flash[:error] = "#{new_deck.errors.full_messages.join(', ')}"
      redirect_to deck_path(original_deck)
    end
  end
  
  private
    def deck_params
      params.require(:deck).permit(:name)
    end
end
