class Meal < ApplicationRecord
  belongs_to :chef
  has_many :cooking_sessions
end
