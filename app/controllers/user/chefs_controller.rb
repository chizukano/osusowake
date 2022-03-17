class User::ChefsController < ApplicationController
  def new
    @chef = Chef.new
  end

  # post /user/chef
  def create
    @chef = Chef.new(chef_params)
    @chef.user = current_user

    if @chef.save
      redirect_to user_chef_path
    else
      render :new
    end
  end

  def show
  end

  private

  def chef_params
    params.require(:chef).permit(:address)
  end
end
