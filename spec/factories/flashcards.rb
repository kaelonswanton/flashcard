FactoryBot.define do
  factory :flashcard do
    front { "front" }
    back { "back" }
    
    association :user, factory: :user
    association :deck, factory: :deck
  end
end