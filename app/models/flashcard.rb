class Flashcard < ApplicationRecord
  belongs_to :deck
  has_one :user, through: :deck
  has_many :reviews, dependent: :destroy


  validates :front, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :back, presence: true, length: { maximum: 100 }, uniqueness: true

end
