class Flashcard < ApplicationRecord
  belongs_to :deck
  has_one :user, through: :deck
  has_many :reviews, dependent: :destroy
  validates :front, presence: true, length: { maximum: 100 }
  validates :back, presence: true, length: { maximum: 100 }
  
  before_create :set_default_difficulty
  after_touch :recalculate_difficulty

  private
    def set_default_difficulty
      self.difficulty = 3.0
    end

    def recalculate_difficulty
      self.difficulty = reviews.average(:difficulty)
      self.save!
    end

end
