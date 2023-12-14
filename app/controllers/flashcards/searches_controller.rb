module Flashcards
  class SearchesController < ApplicationController
    def index
      #Matches user_id through the Flashcard's deck_id
      @q = Flashcard.joins(:deck).where(decks: { user_id: current_user.id }).ransack(params[:q])
      @pagy, @flashcards = pagy(@q.result(distinct: true), items: 10)
    end
  end
end
