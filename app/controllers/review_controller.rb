class ReviewController < ApplicationController
  def index
    @deck = current_user.decks.find(params[:id])
    @fetched_flashcards = @deck.flashcards.order(difficulty: :asc, lastupdated: :asc).limit(20)

    #pagination
    @card_per_page = 1
    @page = params.fetch(:page, 0).to_i
    @flashcards = @fetched_flashcards.offset(@page * @card_per_page).limit(@card_per_page)
    
  end

  def update
    @deck = current_user.decks.find(params[:id])
    # pagination
    @fetched_flashcards = @deck.flashcards.order(difficulty: :asc, lastupdated: :asc).limit(20)
    @flashcard = @fetched_flashcards.first

    if params[:rating] == "Easy"
      @flashcard.update(difficulty: 1)
    elsif params[:rating] == "Medium"
      @flashcard.update(difficulty: 2)
    elsif params[:rating] == "Hard"
      @flashcard.update(difficulty: 3)
    end
  end
end
