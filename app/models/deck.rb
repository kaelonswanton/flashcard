class Deck < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
end
