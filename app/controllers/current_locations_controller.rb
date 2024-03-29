class CurrentLocationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]

  def create
    last_location.update_with(query: location_params.values, max_distance: 20)

    redirect_to cooking_sessions_path
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end
