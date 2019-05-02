# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :user, through: :entries
  has_many :messages, dependent: :destroy
end
