class CookingSessionsController < ApplicationController
  def show
    @cooking_session = CookingSession.find(params[:id])
  end

  def index
    if search_params[:query].present?
      @search_result = search_result
      max_distance = (search_params[:max_distance].presence || 20).to_i
      @cooking_sessions = CookingSession.near(@search_result, max_distance)
    else
      @cooking_sessions = CookingSession.all
    end
  end

  private

  def search_params
    params.fetch(:search, default_search_params).permit(:query, :max_distance)
  end

  def default_search_params
    {}
  end

  def search_result
    best_result = Geocoder.search(search_params[:query]).first
    redirect_to root_path, notice: "Invalid address." if best_result.nil?

    [best_result.latitude, best_result.longitude]
  end
end
