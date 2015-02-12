# Simple attribute handling for resources
# Ties in with ZerigoDNS::Resource by defining a 
# from_response method to initialize the class by its attributes. 
module ZerigoDNS::Resource::Naming
  
  module ClassMethods
    # Default Resource Name
    # @return [String] generated resource name from class name "e.g. ZerigoDNS::ZoneTemplate -> zone_template"
    def default_resource_name
      result = self.to_s.split("::").last.gsub(/([A-Z])/, '_\1').downcase
      result.slice 1, result.length
    end
    
    
    # Default base path.
    # @return [String] Generated base path from class name (default_resource_name + "s")
    def default_base_path
      "#{underscore_path}s"
    end
    
    
    # Sets & gets the "resource name", which is required for the create & update actions.
    # @param [String] name resource name
    # @return [String] the base path
    def resource_name name=nil
      if name
        @resource_name = name
      end
      @resource_name || default_resource_name
    end
    
    # Sets or gets the "base path", where the resource is located.
    # @param [String] path base path
    # @return [String] the base path
    def base_path path=nil
      if path
        @base_path = path
      end
      @base_path || default_base_path
    end
  end
  
  
  def self.included includer
    includer.send :extend, ClassMethods
  end
end
