class CookingSession < ApplicationRecord
  belongs_to :meal
  geocoded_by :address

  validates :latitude, :longitude, presence: true
  # no need for after validate callback for geocode, we`ll add lat and lng on create

  def chef_name
    meal.chef.user.username
  end
end
