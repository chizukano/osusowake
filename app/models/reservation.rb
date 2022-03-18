class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :cooking_session
end

