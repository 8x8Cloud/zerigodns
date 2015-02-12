# A lightweight resource class that will do much of the work of ActiveResource
# without the big dependencies.

module ZerigoDNS::Resource
  module ClassMethods
    # Removes the root from the response and hands it off to the class to process it
    # Processes an array response by delegating to the includer's self.from_response
    # @param [Faraday::Response] response The response
    # @return [Object] The result of the parsed response.
    def process_response response
      without_root = response.body.values.first
      case
      when without_root.is_a?(Array) then process_array(response, without_root)
      when without_root.is_a?(Hash) then from_response(response, without_root)
      else without_root
      end
    end
    
    
    # Processes an array response by delegating to the includer's self.from_response
    # @param [Faraday::Response] response The response
    # @param [Array] body The response body, with root removed
    # @return [Array] The resultant array.
    def process_array response, body
      body.map do |element|
        from_response response, element
      end
    end
  end
  
  
  def self.included includer
    includer.send :include, Attributes
    includer.send :include, Rest
    includer.send :include, Naming
    includer.send :extend, ClassMethods
  end
end
