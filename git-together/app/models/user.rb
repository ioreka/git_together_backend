class User < ApplicationRecord
  has_many :userevents
  has_many :comments
  has_many :events, through: :userevents
end
