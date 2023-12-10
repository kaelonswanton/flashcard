class SearchController < ApplicationController
  def index
    @q = Deck.ransack(params[:q])
    @pagy, @decks = pagy(@q.result(distinct: true).where.not(user_id: current_user.id), items: 10)
  end
end