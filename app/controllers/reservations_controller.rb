class ReservationsController < ApplicationController
  # POST /cooking_sessions/5/reservations


  # POST /cooking_sessions/:cooking_session_id/reservations
  # params => {cooking_session_id: 5}


  # POST /cooking_sessions/:id/reservations
  # param => {id: 5}
  def create
    @cooking_session = CookingSession.find(params[:cooking_session_id])
    @cooking_session = Cooking_session_id.portions_count

  end

end
