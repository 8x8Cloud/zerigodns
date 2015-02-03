# Simple XML parsing middleware for Faraday.
# uses +multi_xml+.
class ZerigoDNS::Middleware::Xml < Faraday::Middleware
  
  XML_REGEXP = /xml/
  
  
  # Parse the XML, if XML exists.
  # Note: This +must+ return the response in order for the stack of middleware to continue.
  # @return [Faraday::Response] The response received
  def call response
    if xml?(response)
      response[:raw_body] = response[:body]
      response[:body] = MultiXml.parse(response[:body])
    end
    response
  end
  
  
  private
  
  def xml? env
    !!XML_REGEXP.match(env[:response_headers]['Content-Type'])
  end
end
