class Room < ApplicationRecord
  has_many :entries
  has_many :user, through: :entries
end
