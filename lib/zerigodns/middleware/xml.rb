# Simple XML parsing middleware for Faraday.
# uses +multi_xml+.
class ZerigoDNS::Middleware::Xml < Faraday::Middleware
  
  XML_REGEXP = /xml/
  
  
  # Parse the XML, if XML exists.
  # Note: This +must+ return the response in order for the stack of middleware to continue.
  # @return [Faraday::Response] The response received
  def call request_env
    @app.call(request_env).on_complete do |response|
      if xml?(response)
        response[:raw_body] = response[:body]
        response[:body] = MultiXml.parse(response[:body])
      end
      response
    end
  end
  
  
  private
  
  def xml? env
    !!XML_REGEXP.match(env[:response_headers]['Content-Type'])
  end
end

Faraday::Response.register_middleware custom_xml: ZerigoDNS::Middleware::Xml
