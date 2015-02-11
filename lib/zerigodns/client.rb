module ZerigoDNS
  class Client
    
    #@!attribute response [r]
    # @!return [Faraday::Response] exposes the response.
    ResponseError = Class.new(RuntimeError) do 
      attr_reader :response
      # Initialize a new ResponseError with a response.
      def initialize response=nil
        @response=response
      end
      
      # Convert to a string
      # @return [String] The error's message.
      def to_s
        inspect
      end
      
      # @return [String] The error's message
      def message
        inspect
      end
      
      # @return [String] The error's message
      def inspect
        "HTTP Response Error: #{response && response.status}"
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
        
        # => Note:  Order matters here!
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
