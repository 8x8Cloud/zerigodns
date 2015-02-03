# Rasies exceptions on errors
class ZerigoDNS::Middleware::ErrorHandler < Faraday::Middleware
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
  
  
  def call request_env
    @app.call(request_env).on_complete do |response|
      if ok?(response)
        response
      else
        raise ZerigoDNS::Client::ResponseError.new(response)
      end
    end
  end
end

Faraday::Response.register_middleware custom_error_handler: lambda {ZerigoDNS::Middleware::ErrorHandler}
