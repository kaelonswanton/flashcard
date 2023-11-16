class FlashcardsController < ApplicationController
  def new
    @flashcard = Flashcard.new
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)
    @flashcard.difficulty = 0
    if @flashcard.save
      flash.now[:message] = "Card added successfully!"
      redirect_to new_flashcard_path
    else
      render new_flashcard_path, status: :unprocessable_entity 
    end
  end

  private
    def flashcard_params
      params.require(:flashcard).permit(:front, :back, :deck_id)
    end
end
