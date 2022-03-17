class User::MealsController < ApplicationController
  def new
    @meal = Meal.new
    @chef = current_user
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.chef = current_user.chef

    if @meal.save
      redirect_to new_user_chef_cooking_session_path
    else
      render :new
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description)
  end
end
