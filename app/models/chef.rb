class Chef < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_many :cooking_sessions, through: :meals

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def streams?
    twitch_channel.present?
  end
end
