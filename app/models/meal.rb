class Meal < ApplicationRecord
  belongs_to :chef
  has_many :cooking_sessions
  has_one_attached :photo
end
