class CookingSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]

  def show
    @cooking_session = CookingSession.find(params[:id])
    @reservation = Reservation.new

    @markers = [
      { lat: @cooking_session.latitude,
        lng: @cooking_session.longitude
      }
    ]
  end

  def index
    if search_params[:query].present?
      update_last_location
      @cooking_sessions = CookingSession.includes(meal: { chef: :user }).near(last_location.address, last_location.max_distance)
    else
      @cooking_sessions = CookingSession.includes(meal: { chef: :user }).all
    end
  end

  private

  def search_params
    params.fetch(:search, default_search_params).permit(:query, :max_distance)
  end

  def default_search_params
    {}
  end

  def update_last_location
    update_session = last_location.update_with(query: search_params[:query], max_distance: search_params[:max_distance].presence || 20)
    redirect_to root_path, notice: "Invalid address." unless update_session
  end

  def new
    @cooking_sessions = @Cooking_session.new
  end
end
