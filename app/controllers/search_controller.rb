class SearchController < ApplicationController
  def index
    @q = Deck.ransack(params[:q])
    @decks = @q.result(distinct: true).where.not(user_id: current_user.id)  
  end
end
