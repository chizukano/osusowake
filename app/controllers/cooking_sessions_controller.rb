class CookingSessionsController < ApplicationController

  def show
    @cooking_session = CookingSession.find(params[:id])
    @reservation = Reservation.new
  end

  def index
    @cooking_sessions = CookingSession.all
  end

  def new
    @cooking_sessions = @Cooking_session.new
  end
end
