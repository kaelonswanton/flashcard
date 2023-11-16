class Deck < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
end
