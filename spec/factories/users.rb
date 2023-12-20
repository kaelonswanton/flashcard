FactoryBot.define do
  factory :user do
    sequence(:username) { Faker::Internet.unique.username }
    sequence(:email) { Faker::Internet.unique.email }
    password { "password" }
  end
end