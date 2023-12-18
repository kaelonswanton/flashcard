FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "example#{n}"}
    sequence(:email) { |n| "example#{n}@example.com"}
    password { "password" }
  end
end