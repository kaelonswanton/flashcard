FactoryBot.define do
  factory :flashcard do
    front { "front" }
    back { "back" }
    difficulty { 0 }
    
    association :user, factory: :user
    association :deck, factory: :deck
  end
end