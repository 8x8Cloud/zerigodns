# Rasies exceptions on errors
class ZerigoDNS::Middleware::ErrorHandler < Faraday::Middleware
  def initialize app=nil, options={}
    @app = app
    @options = options
  end
  
  # Rasies an exception on a bad response.
  
  
  def call request_env
    @app.call(request_env).on_complete do |response|
      response[:code] = ZerigoDNS::Client::ResponseCode.new(response.status)
      if response[:code].ok?
        response
      else
        raise ZerigoDNS::Client::ResponseError.new(response)
      end
    end
  end
end

Faraday::Response.register_middleware custom_error_handler: lambda {ZerigoDNS::Middleware::ErrorHandler}
