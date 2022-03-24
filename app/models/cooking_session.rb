class CookingSession < ApplicationRecord
  belongs_to :meal
  has_many :reservations
  has_one :chef, through: :meal
  geocoded_by :address

  validates :latitude, :longitude, presence: true
  # no need for after validate callback for geocode, we`ll add lat and lng on create

  # In case we want to have max_portion:1 as default setting for #new form
  # attribute :max_portions, :integer, default: 1

  scope :upcoming, -> { order(end_at: :asc).where("end_at > ?", Time.current) }
  scope :today, -> { where("end_at BETWEEN :day_start AND :day_end", day_start: Date.current.beginning_of_day, day_end: Date.current.end_of_day) }
  scope :tomorrow_onwards, -> { where("end_at > ?", Time.current + 24.hours) }

  scope :not_from, ->(chef) { where.not(meal: { chef: chef }) }

  def chef_name
    meal.chef.user.username
  end

  def meal_name
    meal.name
  end

  def created_by
    meal.chef.user
  end

  def portions_left
    max_portions - reservations.sum(:portion_count)
  end

  def portions_reserved
    reservations.sum(:portion_count)
  end

  def ratio_of_portions_reserved
    (max_portions - portions_left).fdiv(max_portions)
  end
end
