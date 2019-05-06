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

class Message < ApplicationRecord
  belongs_to :room
  validates :message, presence: true, length: { maximum: 1024 }
end
