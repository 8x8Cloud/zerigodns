module ZerigoDNS
  class Client
    
    #@!attribute response [r]
    # @!return [Faraday::Response] exposes the response.
    ResponseError = Class.new(RuntimeError) do 
      attr_reader :response
      
      def initialize response=nil
        @response=response
      end
    end
    
    ACTIONS = %w(get post put patch delete)
    
    ACTIONS.each do |action|
      define_method action do |*args|
        self.class.send(action, *args)
      end
    end
    
    
    class <<self
      # Gets or creates a new faraday connection.
      def connection
        
        # => Note: Middleware is executed in the order it is defined!
        # TODO:  Wrap the basic_auth middleware to allow for config changes.
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
