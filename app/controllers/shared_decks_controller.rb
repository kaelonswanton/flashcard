class SharedDecksController < ApplicationController
  def index
    @pagy, @decks = pagy(current_user.decks.where(shared: true))
  end

  def update
    @deck = current_user.decks.find(params[:id])
    @deck.update(shared: true)
    redirect_to shared_decks_path
  end
end
