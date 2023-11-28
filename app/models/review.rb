class Review < ApplicationRecord
  belongs_to :flashcard
  belongs_to :user

  after_save :update_flashcard_average_rating

  private
    def update_flashcard_average_rating
      
    end
end
