FactoryBot.define do
  factory :deck do
    association :user, factory: :user
    name { 'test' }
  end
end