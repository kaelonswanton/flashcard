class RenameVoteScoreInDecks < ActiveRecord::Migration[7.0]
  def change
    rename_column :decks, :VoteScore, :vote_score
  end
end
