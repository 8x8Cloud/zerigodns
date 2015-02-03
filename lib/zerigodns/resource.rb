# A lightweight resource class that will take much coding out of the individual resource classes.
# it is up to the includer to define self.from_response(response, body)
module ZerigoDNS::Resource
  module ClassMethods
    # Removes the root from the response and hands it off to the class to process it
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
    # @return [Array] The resultant array.
    def process_array response, body
      body.map do |element|
        from_response response, element
      end
    end
    
    def resource_name *args
      if args.length == 1
        @resource_name = args.first
        return
      else 
        return @resource_name
      end
      
      raise ArgumentError, "Invalid number of arguments (1 for (0..1))"
    end
    
    def base_path *args
      if args.length == 1
        @base_path = args.first
        return
      else 
        return @base_path
      end
      
      raise ArgumentError, "Invalid number of arguments (1 for (0..1))"
    end
  end
  
  
  def self.included includer
    includer.send :include, Attributes
    includer.send :include, Finders
    includer.send :extend, ClassMethods
  end
end
