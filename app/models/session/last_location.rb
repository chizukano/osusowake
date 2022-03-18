class Session::LastLocation
  def initialize(session)
    @session = session
  end

  def update_with(query:, max_distance:)
    best_result = Geocoder.search(query).first
    return false if best_result.nil?

    @session[:address] = query
    @session[:max_distance] = max_distance.to_i
    @session[:latitude] = best_result.latitude
    @session[:longitude] = best_result.longitude
  end

  def coordinates
    [latitude, longitude]
  end

  def latitude
    @session[:latitude]
  end

  def longitude
    @session[:longitude]
  end

  def max_distance
    @session[:max_distance].to_i
  end

  def address
    @session[:address]
  end
end
