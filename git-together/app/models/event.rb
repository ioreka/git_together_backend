class Event < ApplicationRecord
  has_many :userevents
  has_many :comments
  has_many :users, through: :userevents
end
