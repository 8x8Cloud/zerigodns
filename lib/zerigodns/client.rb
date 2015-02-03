module ZerigoDNS
  class Client

    ACTIONS = %w(get post put patch delete)
    
    class <<self
      
      def connection
        
        # => Note: The order of the middleware matters
        @connection ||= Faraday.new(
          url: ZerigoDNS.config.site, 
        ) do |faraday|
          faraday.use Faraday::Request::BasicAuthentication, ZerigoDNS.config.user, ZerigoDNS.config.api_key
          faraday.use Faraday::Request::Multipart
          faraday.use Faraday::Request::UrlEncoded
          faraday.use Faraday::Adapter::NetHttp
          faraday.use ZerigoDNS::Middleware::Xml
          faraday.use ZerigoDNS::Middleware::ErrorHandler
        end
      end
      
      ACTIONS.each do |action|
        define_method action do |*args|
          connection.send action, *args
        end
      end
    end
  end
end
