class Vote < ApplicationRecord
  after_save :update_deck_score
  after_destroy :update_deck_score

  belongs_to :user
  belongs_to :deck
  validates :user_id, uniqueness: { scope: :deck_id }

  private

  def update_deck_score
    deck.update(vote_score: deck.deck_score)
  end
end
