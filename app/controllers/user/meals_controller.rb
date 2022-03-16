class User::MealsController < ApplicationController
  def new
    @meal = Meal.new
    @chef = current_user
  end

  def create
    @meal = Meal.new(meal_params)
    @chef = current_user

    if @meal.save
      redirect_to meals_path
    else
      render :new
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description)
  end
end
