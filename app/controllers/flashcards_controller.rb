class FlashcardsController < ApplicationController
  def new
    @flashcard = Flashcard.new
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)
    @flashcard.difficulty = 0
    if @flashcard.save
      flash[:message] = "Flashcard added successfully!"
      redirect_to new_flashcard_path
    else
      render new_flashcard_path, status: :unprocessable_entity 
    end
  end

  def destroy
    deck_id = params[:id]
    flashcard = Flashcard.find(params[:id])
    flashcard.destroy
    flash[:message] = "Flashcard destroyed successfully!"
    redirect_to deck_id
  end

  private
    def flashcard_params
      params.require(:flashcard).permit(:front, :back, :deck_id)
    end
end
