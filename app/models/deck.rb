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

  #uniqueness: { scope: :user_id } makes it so validations only occur for the specific user
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { scope: :user_id, case_sensitive: false }
end
