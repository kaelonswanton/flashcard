class Review < ApplicationRecord
  belongs_to :flashcard, touch: true
  belongs_to :user
  
end
