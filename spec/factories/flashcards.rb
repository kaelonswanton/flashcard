FactoryBot.define do
  factory :flashcard do
    front { Faker::Lorem.sentence(word_count: 3) }
    back { Faker::Lorem.sentence(word_count: 3) }

    
    association :user, factory: :user
    association :deck, factory: :deck
  end
end