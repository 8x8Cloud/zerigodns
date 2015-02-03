# Puts a basic resource abstraction over basic REST calls.
module Finders
  module InstanceMethods
    def update params
      self.class.update id, params
      @attributes.merge!(params)
    end
  end
  
  module ClassMethods
    
    # Lists all resources
    # @return [Array] The resources as an array
    def all params={}
      process_response get("#{base_path}.xml", params)
    end
    
    # Find a single resource
    def find id_or_name, params={}
      process_response get("#{base_path}/#{id_or_name}.xml", params)
    end
    
    # Updates a single resource
    def update id_or_name, params={}
      process_response(put "#{base_path}/#{id_or_name}.xml", convert(params))
    end
    
    # Creates a resource
    def create params={}
      process_response(post "#{base_path}.xml", convert(params))
    end
    
    # Deletes a resource
    def destroy
      delete "/api/1.1/#{self.class.base_path}/#{id_or_name}.xml", params
    end
    
    
    private
    
    # Converts a resource object to a hash.
    # @param [Object] object to convert to a hash
    # @raise [ArgumentError] if the object given does not respond to to_hash
    def convert object
      return {resource_name => object} if object.is_a? Hash
      raise ArgumentError, "Expected #{object} to respond to to_hash" unless object.respond_to?(:to_hash)
      {resource_name =>  object.to_hash}
    end
    
  end
  
  def self.included includer
    includer.send :include, InstanceMethods
    includer.send :extend, ClassMethods
  end
end  

