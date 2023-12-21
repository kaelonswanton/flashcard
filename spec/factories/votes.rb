FactoryBot.define do
  factory :vote do
    association :user, factory: :user
    association :deck, factory: :deck  
  end
end
