FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "rails_tutorial#{format('%03d', n)}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
