class DecksController < ApplicationController
  def index
  end

  def create
    @user = current_user
    @deck = @user.decks.build(deck_params)
    if @deck.save
      flash.now[:message] = "Deck created successfully!"
      redirect_to decks_path
    else
      render 'decks/index', status: :unprocessable_entity
    end
  end


  private
    def deck_params
      params.require(:deck).permit(:name)
    end
end
