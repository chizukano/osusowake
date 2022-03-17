class User::CookingSessionsController < ApplicationController
  def new
    @cooking_session = CookingSession.new
    @meals = current_user.chef.meals
  end

  def create
    @cooking_session = CookingSession.new(cooking_session_params)
    @cooking_session.address = current_user.chef.address
    @cooking_session.latitude = current_user.chef.latitude
    @cooking_session.longitude = current_user.chef.longitude

    if @cooking_session.save
      redirect_to user_chef_path
      # tentative path that redirects to index of cooking sessions
    else
      render :new
    end
  end

  private

  def cooking_session_params
    params.require(:cooking_session).permit(:max_portions, :end_at, :meal_id)
  end

end
