class SharedDecksController < ApplicationController
  def index
    @pagy, @decks = pagy(current_user.decks.where(shared: true))
  end

  def update
    @deck = current_user.decks.find(params[:id])
    if @deck.update(deck_params)
      flash[:message] = @deck.shared ? "Deck shared successfully!" : "Deck unshared successfully!" 
      redirect_to shared_decks_path
    else
      flash[:error] = @deck.errors.full_messages.join(", ")
      redirect_to shared_decks_path
    end
  end

  private
    def deck_params
      params.require(:deck).permit(:shared)
    end
end
