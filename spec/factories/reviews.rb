FactoryBot.define do
  factory :review do
    difficulty { 1 }
    
    association :user, factory: :user
    association :flashcard, factory: :flashcard
  end
end
