class CookingSession < ApplicationRecord
  belongs_to :meal
  geocoded_by :address

  validates :latitude, :longitude, presence: true
  # no need for after validate callback for geocode, we`ll add lat and lng on create
  # In case we want to have max_portion:1 as default setting for #new form
  # attribute :max_portions, :integer, default: 1

  scope :upcoming, -> { order(end_at: :asc).where("end_at > ?", Time.current) }

  def chef_name
    meal.chef.user.username
  end

  def meal_name
    meal.name
  end
end
