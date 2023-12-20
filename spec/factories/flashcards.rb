FactoryBot.define do
  factory :flashcard do
    front { Faker::Lorem.sentence(word_count: 3) }
    back { Faker::Lorem.sentence(word_count: 3) }
    #created_at { 1.month.ago }
    #updated_at { 1.month.ago } will mark the card ready for review 
    association :user, factory: :user
    association :deck, factory: :deck
  end
end