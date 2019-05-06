# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  message      :string
#  send_user_id :integer          not null
#  room_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :message do
    
  end
end
