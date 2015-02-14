# Handles authentication using the Zerigo config.
class ZerigoDNS::Middleware::ZerigoAuth < Faraday::Middleware
  # Constructs new middleware instance
  def initialize app=nil, options={}
    @app = app
  end
  
  # Adds username & api key to Basic Auth header.
  # @param [Faraday::Request] env The request
  def call env
    # => Ruby 1.8.7 does not support Base64.strict_encode64
    auth_enc = Base64.encode64(formatted_login).gsub("\n", '')
    env.request_headers['Authorization'] = "Basic #{auth_enc}"
    @app.call(env)
  end
  
  private
  
  # Gets the user:password format from ZerigoDNS.config
  # @return [String] formatted login details
  def formatted_login
    [ZerigoDNS.config.user, ZerigoDNS.config.api_key].join(':')
  end
end

Faraday::Request.register_middleware zerigo_auth: ZerigoDNS::Middleware::ZerigoAuth
