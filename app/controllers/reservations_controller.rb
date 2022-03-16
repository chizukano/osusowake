class ReservationsController < ApplicationController
  def show
    @reservation = Reservation.find(params[:id])
    @cooking_session = @reservation.cooking_session
  end
end
