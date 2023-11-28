FactoryBot.define do
  factory :review do
    difficulty { 1 }
    average_rating { 1.8 }
    next_review_at { "2023-11-27 18:19:48" }
    flashcard { 1 }
    user { 1 }
  end
end
