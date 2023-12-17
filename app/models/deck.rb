class Deck < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy
  has_many :votes, dependent: :destroy

  # Ransack gem - attributes allowed to be search
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  #uniqueness: { scope: :user_id } makes it so validations only occur for the specific user
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: :user_id, case_sensitive: false }
  
  validate :cannot_share_empty_deck
  validate :cannot_share_already_shared_deck

  def cannot_share_empty_deck
    if shared && flashcards.empty?
      errors.add(:base, "Deck cannot be shared if empty.")
    end
  end

  def cannot_share_already_shared_deck
    #this is to ensure a deck can be shared/name edited, but can't be double shared
    if previous_changes.include?("shared") && shared
      errors.add(:base, "Deck is already shared.")
    end
  end
end
