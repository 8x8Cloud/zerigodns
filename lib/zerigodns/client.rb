module ZerigoDNS
  class Client
    ResponseError = Class.new(RuntimeError) do 
      attr_reader :response
      
      def initialize response=nil
        @response=response
      end
    end
    ACTIONS = %w(get post put patch delete)
    
    class <<self
      
      def connection
        
        # => Note: The order of the middleware matters
        @connection ||= Faraday.new(
          url: ZerigoDNS.config.site, 
        ) do |faraday|
          faraday.request :basic_auth, ZerigoDNS.config.user, ZerigoDNS.config.api_key
          faraday.request :multipart
          faraday.request :url_encoded
          
          faraday.adapter Faraday.default_adapter
          
          faraday.response :custom_xml
          faraday.response :custom_error_handler
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
