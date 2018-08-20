class Event < ApplicationRecord
  has_many :user_events
  has_many :comments
  has_many :users, through: :user_events
end
