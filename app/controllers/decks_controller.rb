class DecksController < ApplicationController
  before_action :authenticate_user!
  def index
    @deck = current_user.decks.build
    @decks = current_user.decks.all
  end

  def show
    @deck = current_user.decks.find(params[:id])
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

  private
    def deck_params
      params.require(:deck).permit(:name)
    end
end
