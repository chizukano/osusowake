class CookingSessionsController < ApplicationController
  def index
    @cooking_sessions = CookingSessions.all
  end
end
