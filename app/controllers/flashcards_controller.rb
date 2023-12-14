class FlashcardsController < ApplicationController
  before_action :authenticate_user! 
  def new
    @flashcard = Flashcard.new
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)
    if @flashcard.save
      flash[:message] = "Flashcard added successfully!"
      redirect_to new_flashcard_path
    else
      render new_flashcard_path, status: :unprocessable_entity 
    end
  end

  def edit
    @flashcard = Flashcard.find(params[:id])
  end

  def update
    @flashcard = Flashcard.find(params[:id])
    @deck = @flashcard.deck

    if @flashcard.update(flashcard_params)
      flash[:message] = "Flashcard updated successfully!"
      redirect_to deck_path(@deck)
    else
      render decks_path, status: :unprocessable_entity
    end

  end

  def destroy
    flashcard = Flashcard.find(params[:id])
    deck_id = flashcard.deck.id
    flashcard.destroy
    flash[:message] = "Flashcard deleted successfully!"
    redirect_to deck_path(deck_id)
  end


  private
    def flashcard_params
      params.require(:flashcard).permit(:front, :back, :deck_id)
    end
end
