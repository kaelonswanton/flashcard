class Deck < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  belongs_to :user
  has_many :flashcards, dependent: :destroy
  has_many :votes, dependent: :destroy

  #uniqueness: { scope: :user_id } makes it so validations only occur for the specific user
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: :user_id, case_sensitive: false }
  validate :cannot_share_empty_deck
  validate :cannot_share_already_shared_deck

  def cannot_share_empty_deck
    if shared && flashcards.empty?
      #puts error messsages in console
      errors.add(:base, "Deck cannot be shared if empty.")
    end
  end

    #deck cannot be double shared
  def cannot_share_already_shared_deck
    if !will_save_change_to_shared? && shared
      errors.add(:base, "Deck is already shared.")
    end
  end

  def deck_score
    upvotes = votes.where(type: "Upvote").count
    downvotes = votes.where(type: "Downvote").count
    upvotes - downvotes
  end
end
