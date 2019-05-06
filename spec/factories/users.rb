# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string
#  email             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string
#  remember_digest   :string
#  admin             :boolean          default(FALSE)
#  activation_digest :string
#  activated         :boolean
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "rails_tutorial#{format('%03d', n)}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
    activated_at { Time.zone.now }

    trait :user_with_microposts do
      transient do
        microposts_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:micropost, evaluator.microposts_count, user: user)
      end
    end
  end
end
