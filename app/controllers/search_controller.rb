class SearchController < ApplicationController
  def index
    @q = Deck.ransack(params[:q])
    @decks = @q.result(distinct: true)
  end
end
