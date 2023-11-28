class ReviewController < ApplicationController
  def show
    @deck = Deck.find(params[:deck_id])
    if session[:fetched_flashcards].nil?
      session[:fetched_flashcards] = @deck.flashcards.order(difficulty: :desc, average_rating: :desc).limit(20).pluck(:id)
    end
    @page_number = params[:id].to_i
    @flashcard = Flashcard.find(session[:fetched_flashcards][@page_number])
  end

  def update
    @deck = Deck.find(params[:deck_id])
    @page_number = params[:id].to_i
    @flashcard = Flashcard.find(session[:fetched_flashcards][@page_number])

    difficulty_levels = { "Easy" => 1, "Medium" => 2, "Hard" => 3}
    if difficulty_levels.include?(params[:rating])
      @flashcard.update(difficulty: difficulty_levels[params[:rating]])
      if @page_number == sesssion[:fetched_flashcards].length -1
        session.delete(:fetched_flashcards)
        redirect_to decks_path
      else
        redirect_to deck_review_path(@deck, id: @page_number + 1)
      end
    end
  end
end

