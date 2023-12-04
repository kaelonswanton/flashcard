class Deck < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy

  # Ransack gem - attributes allowed to be search
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
end
