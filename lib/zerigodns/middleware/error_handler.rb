# Rasies exceptions on errors
class ZerigoDNS::Middleware::ErrorHandler
  def initialize app=nil, options={}
    @app = app
    @options = options
  end
  
  # @return [Boolean] true if the response was OK
  # @raise [ZerigoDNS::Client::ResponseError] if the response was NOT OK.
  def ok? response
    (200..299).include?(response.status) || response.status == 302
  end
  
  # Rasies an exception on a bad response.
  
  
  def call response
    return response if ok?(response)
    ZerigoDNS::Client::ResponseError.new(response)
  end
end
