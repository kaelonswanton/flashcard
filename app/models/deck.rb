class Deck < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["name", "vote_score", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
  before_create :set_default_vote_score

  belongs_to :user
  has_many :flashcards, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: :user_id, case_sensitive: false }
  validate :cannot_share_empty_deck

  def cannot_share_empty_deck
    if shared && flashcards.empty?
      #puts error messsages in console
      errors.add(:base, "Deck cannot be shared if empty.")
    end
  end

  def deck_score
    upvotes = votes.where(type: "Upvote").count
    downvotes = votes.where(type: "Downvote").count
    upvotes - downvotes 
  end

  private
  def set_default_vote_score
    self.vote_score = 0
  end
end
