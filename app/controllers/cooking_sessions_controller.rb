class CookingSessionsController < ApplicationController
  def index
    @cooking_sessions = CookingSession.all
  end
end
