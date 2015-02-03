# Simple attribute handling for resources
# Ties in with ZerigoDNS::Resource by defining a 
# from_response method to initialize the class by its attributes. 
module ZerigoDNS::Resource::Attributes
  module InstanceMethods
    attr_accessor :attributes
    def method_missing mtd, *args
      if mtd.to_s.ends_with?('=')
        attributes[mtd.to_s.slice(0,mtd.to_s.length-1)] = value
      else 
        attributes[mtd.to_s]
      end
    end
    
    
    def initialize attributes={}
      @attributes = attributes
    end
  end
  
  
  module ClassMethods
    def self.from_response response, body
      new body
    end
  end
  
  def self.included includer
    includer.send :include, InstanceMethods
    includer.send :extend, ClassMethods
  end
end
