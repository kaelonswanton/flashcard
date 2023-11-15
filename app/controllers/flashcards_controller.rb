class FlashcardsController < ApplicationController
  def new
    @flashcard = Flashcard.new
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)
    @flashcard.difficulty = 0
    #
  end

  private
    def flashcard_params
      params.require(:flashcard).permit(:front, :back, :deck_id)
    end
end
