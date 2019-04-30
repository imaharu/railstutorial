FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.sentence }
    association :user
  end
end
