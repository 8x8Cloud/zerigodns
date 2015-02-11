# Simple attribute handling for resources
# Ties in with ZerigoDNS::Resource by defining a 
# from_response method to initialize the class by its attributes. 
module ZerigoDNS::Resource::Attributes
  module InstanceMethods
    attr_accessor :attributes
    
    
    # Allows method-style access to the attributes.
    def method_missing mtd, *args
      if mtd.to_s.chars.to_a.last == '='
        raise ArgumentError, "Invalid number of arguments (#{args.length} for 1)" if args.length != 1
        attributes[mtd.to_s.slice(0,mtd.to_s.length-1)] = args.first
      else
        raise ArgumentError, "Invalid number of arguments (#{args.length} for 0)" if args.length != 0
        attributes[mtd.to_s]
      end
    end
    
    # Converts the resource to a hash
    # @return [Hash] The attributes
    def to_hash
      attributes
    end
    
    # Initialize a new resource
    # @param [Hash] attributes Initial attributes.
    def initialize attributes={}
      @attributes = {}
      merge_attributes attributes
    end
    
    private
    
    # Merge current attributes with specified ones.
    # Will handle symbols as well as strings as keys
    # @param [Hash] attrs Attributes to merge
    def merge_attributes attrs
      attrs.each do |key, val|
        send("#{key}=", val)
      end
    end
  end
  
  
  module ClassMethods
    # Constructs a new resource from a response
    # @param [Faraday::Response] response The response
    # @param [Hash] body The response body without root
    def from_response response, body
      new body
    end
  end
  
  def self.included includer
    includer.send :include, InstanceMethods
    includer.send :extend, ClassMethods
  end
end
