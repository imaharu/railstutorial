# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  picture    :string
#

FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.sentence }
    association :user
  end
end
