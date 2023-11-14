class DecksController < ApplicationController
  before_action :authenticate_user!
  def index
    @deck = current_user.decks.build
    @decks = current_user.decks.all
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:message] = "Deck created successfully!"
      redirect_to decks_path
    else
      @decks = current_user.decks
      render 'decks/index', status: :unprocessable_entity
    end
  end

  def destroy
    @decks = current_user.decks
    @deck = current_user.decks.find(params[:id])
    @deck.destroy
    flash[:message] = "Deck deleted successfully!"
    redirect_to decks_path
  end

  private
    def deck_params
      params.require(:deck).permit(:name)
    end
end
