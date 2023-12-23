class VotesController < ApplicationController
  def create
    @deck = Deck.find(params[:deck_id])
    existing_vote = current_user.votes.find_by(deck: @deck)
    vote_type = vote_params[:type]

    # delete if reclicked
    if existing_vote && existing_vote.type == vote_type
      existing_vote.destroy
      redirect_to deck_path(@deck)
    # create a vote
    else
      existing_vote&.destroy
      @vote = @deck.votes.build(vote_params) 
      @vote.user = current_user
      @vote.save
      redirect_to deck_path(@deck) 
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:deck_id, :type)
  end
end
