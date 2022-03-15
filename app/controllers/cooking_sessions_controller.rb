class CookingSessionsController < ApplicationController
  # cooking_sessions/:id
  def show
    @cooking_session = CookingSession.find(params[:id])
  end
end
