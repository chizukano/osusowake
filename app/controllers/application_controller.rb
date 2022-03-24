class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :last_location
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def last_location
    @last_location ||= Session::LastLocation.new(session)
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
