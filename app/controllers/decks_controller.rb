class DecksController < ApplicationController
  before_action :authenticate_user!

  def index
    @deck = current_user.decks.build
    @decks = current_user.decks.all
  end

  def show
    @deck = Deck.find(params[:id])
    @flashcards = @deck.flashcards
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user_id = current_user.id

    if @deck.save
      flash[:message] = "Deck created successfully!"
      redirect_to decks_path
    else
      @decks = current_user.decks
      render 'decks/index', status: :unprocessable_entity
    end
  end

  def edit
    @deck = current_user.decks.find(params[:id])
  end

  def update
    @deck = current_user.decks.find(params[:id])

    if @deck.update(deck_params)
      flash[:message] = "Deck updated successfully!"
      redirect_to decks_path
    else
      @decks = current_user.decks
      render 'decks/index', status: :unprocessable_entity
    end
  end

  def destroy
    decks = current_user.decks
    deck = current_user.decks.find(params[:id])
    deck.destroy
    flash[:message] = "Deck deleted successfully!"
    redirect_to decks_path
  end

  def review_and_reset
    session.delete(:fetched_flashcards)
    redirect_to deck_review_path(params[:id], id: 0)
  end

  def duplicate_deck
    original_deck = current_user.decks.find(params[:id])
    new_deck = origin_deck.dup
    new_deck.user = current_user
    new_deck.save

    #iterate over each card; dupe it
    original_deck.flashcards.each do |flashcard|
      new_flashcard = flashcard.dup
      new_flashcard.deck = new_deck
      new_flashcard.save
    end
  end
  
  private
    def deck_params
      params.require(:deck).permit(:name)
    end
end
