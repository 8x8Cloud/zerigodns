# Simple attribute handling for resources
# Ties in with ZerigoDNS::Resource by defining a 
# from_response method to initialize the class by its attributes. 
module ZerigoDNS::Resource::Attributes
  module InstanceMethods
    attr_accessor :attributes
    def method_missing mtd, *args
      if mtd.to_s.chars.to_a.last == '='
        attributes[mtd.to_s.slice(0,mtd.to_s.length-1)] = args.first
      else 
        attributes[mtd.to_s]
      end
    end
    
    def to_hash
      attributes
    end
    
    def initialize attributes={}
      @attributes = attributes
    end
    
    private
    
    def merge_attributes attrs
      attrs.each do |key, val|
        send("#{key}=", val)
      end
    end
  end
  
  
  module ClassMethods
    def from_response response, body
      new body
    end
  end
  
  def self.included includer
    includer.send :include, InstanceMethods
    includer.send :extend, ClassMethods
  end
end
