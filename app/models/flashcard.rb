class Flashcard < ApplicationRecord
  belongs_to :deck
  has_one :user, through: :deck
  has_many :reviews, dependent: :destroy
  validates :front, presence: true, length: { maximum: 100 }
  validates :back, presence: true, length: { maximum: 100 }
  
  before_create :set_default_difficulty
  after_touch :recalculate_difficulty

  def self.ransackable_attributes(auth_object = nil)
    ["back", "created_at", "deck_id", "difficulty", "front", "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["deck", "reviews", "user"]
  end

  def fresh_card?
    self.reviews.count < 3
  end

  def new_flashcard?
    self.difficulty == 4.0
  end

  def ready_for_review?
    time_since_last_review = Time.now - self.updated_at
    case self.difficulty
    #fresh_card  
    when 1.0..1.67
      if fresh_card?
        time_since_last_review > 1.day
      else
        time_since_last_review > 1.week
      end
    when 1.68..2.34
      if fresh_card?
        time_since_last_review > 1.hour
      else
        time_since_last_review > 3.days
      end
    when 2.35..3.0
      if fresh_card?
        time_since_last_review > 5.minutes
      else
        time_since_last_review > 1.day
      end
    end
  end

  private
    def set_default_difficulty
      self.difficulty = 4.0
    end

    def recalculate_difficulty
      self.difficulty = reviews.average(:difficulty)
      self.save!
    end
end
