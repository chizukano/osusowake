class ReservationsController < ApplicationController
  # POST /cooking_sessions/5/reservations


  # POST /cooking_sessions/:cooking_session_id/reservations
  # params => {cooking_session_id: 5}
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
     @reservation = CookingSession.find(params[:id])
    
  end

  private

  def reservation_params
    params.require(:reservation).permit(:portion_count)
  end
end
