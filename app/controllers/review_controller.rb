class ReviewController < ApplicationController
  def show
    @deck = Deck.find(params[:deck_id])
    if session[:fetched_flashcards].nil?
      session[:fetched_flashcards] = @deck.flashcards.order(difficulty: :desc).limit(20).pluck(:id)
    end
    @page_number = params[:id].to_i
    @flashcard = Flashcard.find(session[:fetched_flashcards][@page_number])
  end

  def update
      @deck = Deck.find(params[:deck_id])
      @page_number = params[:id].to_i
      @flashcard = Flashcard.find(session[:fetched_flashcards][@page_number])
    
      if params[:rating] == "Easy"
        review = @flashcard.reviews.create(difficulty: 1, user: current_user)
      elsif params[:rating] == "Medium"
        review = @flashcard.reviews.create(difficulty: 2, user: current_user)
      elsif params[:rating] == "Hard"
        review = @flashcard.reviews.create(difficulty: 3, user: current_user)
      end
    
      if @page_number == session[:fetched_flashcards].length - 1
        session.delete(:fetched_flashcards)
        redirect_to decks_path
      else
        redirect_to deck_review_path(@deck, id: @page_number + 1)
      end
  end
end