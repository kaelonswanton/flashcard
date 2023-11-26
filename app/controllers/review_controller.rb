class ReviewController < ApplicationController
  def show
    @deck = Deck.find(params[:deck_id])
    @fetched_flashcards = @deck.flashcards.order(difficulty: :desc).limit(20)
    @card_number = params[:id].to_i
    @flashcard = @fetched_flashcards[@card_number]
  end

  def update
    @deck = Deck.find(params[:deck_id])
    @fetched_flashcards = @deck.flashcards.order(difficulty: :desc).limit(20)
    @card_number = params[:id].to_i
    @flashcard_id = @fetched_flashcards[@card_number] 
    @flashcard = Flashcard.find(@flashcard_id.id)

    if params[:rating] == "Easy"
      @flashcard.update(difficulty: 1)
      # redirect_to deck_review_path(@deck, id: @card_number + 1)
    elsif params[:rating] == "Medium"
      @flashcard.update(difficulty: 2)
      # redirect_to deck_review_path(@deck, id: @card_number + 1)
    elsif params[:rating] == "Hard"
      @flashcard.update(difficulty: 3)
      # redirect_to deck_review_path(@deck, id: @card_number + 1)
    end
  end

  def private


end

