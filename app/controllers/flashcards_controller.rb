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

  def edit
    @flashcard = Flashcard.find(params[:id])
  end

  def update
    @flashcard = Flashcard.find(params[:id])

    if @flashcard.update(flashcard_params) #it seems to process the create action. problem with form? or maybe finding the id in activerecord so it defaults to create instead of update?
      flash[:message] = "Flashcard successfully updated!"
      redirect_to decks_path
    else
      render 'decks/index', status: :unprocessable_entity
    end

  end

  def destroy
    flashcard = Flashcard.find(params[:id])
    deck_id = flashcard.deck.id
    flashcard.destroy
    flash[:message] = "Flashcard destroyed successfully!"
    redirect_to deck_path(deck_id)
  end

  def review
    @deck = current_user.decks.find(params[:id])

    # pagination
    @fetched_flashcards = @deck.flashcards.order(difficulty: :asc, lastupdated: :asc).limit(20)
    @card_per_page = 1
    @page = params.fetch(:page, 0).to_i
    @flashcards = @fetched_flashcards.offset(@page * 1).limit(1)


  end

  def difficulty_update
    # update form
    @flashcard = @flashcards.first
    if params[:rating] == "Easy"
      @flashcard.difficulty = 1
    elsif params[:rating] == "Medium"
      @flashcard.update(difficulty: 2)
    elsif params[:rating] == "Hard"
      @flashcard.update(difficulty: 3)
    end
  end


  private
    def flashcard_params
      params.require(:flashcard).permit(:front, :back, :deck_id)
    end
end
