module Decks 
  class SearchesController < ApplicationController
    def index
      #Matches user_id through the Flashcard's deck_id
      @q = Deck.where.not(user_id: current_user.id).where(shared: true).ransack(params[:q]) 
      @pagy, @decks = pagy(@q.result(distinct: true), items: 10)
    end
  end
end
