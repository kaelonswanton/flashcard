class VotesController < ApplicationController
  def create
    @deck = Deck.find(params[:deck_id])
    existing_upvote = current_user.upvotes.find_by(deck: @deck)
    existing_downvote = current_user.downvotes.find_by(deck: @deck)
    if params[:type] == "upvote" && existing_upvote 
      existing_upvote.delete
    elsif
      params[:type] == "downvote" && existing_downvote
    else
      @vote = @deck.votes.build(vote_params) 
      @vote.user = current_user
      @vote.save
      redirect_to deck_votes_path(@deck) 
    end
    #vote counter +1
  end

  def destroy
  end

  private
  def vote_params
    params.require(:vote).permit(:deck_id, :type)
  end
end
