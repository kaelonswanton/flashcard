class Flashcard < ApplicationRecord
  belongs_to :deck

  validates :front, presence: true, length: { maximum: 100 }
  validates :back, presence: true, length: { maximum: 100 }

end
