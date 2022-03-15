class CookingSessionsController < ApplicationController

  def show
    @cooking_session = CookingSession.find(params[:id])
  end
  
  def index
    @cooking_sessions = CookingSession.all
  end
end
