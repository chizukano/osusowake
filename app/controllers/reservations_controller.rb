class ReservationsController < ApplicationController
  def create
    @cooking_session = CookingSession.find(params[:cooking_session_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.cooking_session =  @cooking_session

   if @reservation.save
    redirect_to reservation_path(@reservation)
   elsif
    render "cooking_sessions/show"
   end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @cooking_session = @reservation.cooking_session
  end

  private

  def reservation_params
    params.require(:reservation).permit(:portion_count)
  end
end
