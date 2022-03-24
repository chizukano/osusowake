class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @cooking_sessions = CookingSession.includes(meal: { chef: :user }).all
  end
end
