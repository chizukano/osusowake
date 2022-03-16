class User::MealsController < ApplicationController
  def new
    @meal = Meal.new
    @chef = current_user
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.chef = current_user.chef

    if @meal.save
      redirect_to cooking_sessions_path
      # tentative path that redirects to index of cooking sessions
    else
      render :new
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description)
  end
end
