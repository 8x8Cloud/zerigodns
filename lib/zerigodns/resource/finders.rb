# Puts a basic resource abstraction over basic REST calls.
module ZerigoDNS::Resource::Finders
  module InstanceMethods
    
    # Update this instance's resource with attributes supplied into +params+
    # @param [Hash] params The attributes to set
    # @return [Object] The instance on which +update+ was called
    def update params
      self.class.update id, params
      merge_attributes params
      self
    end
    
    # Destroy this instance's resource
    # @param [Hash] params The attributes to set
    # @raise [ZerigoDNS::Client::ResponseError] if delete does not succeed.
    # @return [Faraday::Response] The response returned from the server.
    def destroy params={}
      self.class.destroy id, params
    end
  end
  
  module ClassMethods
    
    # Lists all resources
    # @return [Array] The resources as an array
    def all params={}
      process_response get("#{base_path}.xml", params)
    end
    
    # Find a single resource
    # @param [Object] id_or_name The id or name of the resource to find
    # @raise [ZerigoDNS::Client::ResponseError] if the find does not succeed.
    # @return [Object] The requested resource.
    def find id_or_name, params={}
      process_response get("#{base_path}/#{id_or_name}.xml", params)
    end
    
    # Updates a single resource
    # @param [Object] id_or_name Id or name of the resource
    # @raise [ZerigoDNS::Client::ResponseError] if update does not succeed.
    # @return [Faraday::Response] The response returned by the server.
    def update id_or_name, params={}
      put "#{base_path}/#{id_or_name}.xml", convert(params)
    end
    
    # Creates a resource
    # @param [Object] params Parameters to pass to create action
    # @raise [ZerigoDNS::Client::ResponseError] if create does not succeed.
    # @return [Object] the created resource
    def create params={}
      process_response(post "#{base_path}.xml", convert(params))
    end
    
    # Deletes a resource
    # @param [Object] params Parameters to pass to delete action
    # @raise [ZerigoDNS::Client::ResponseError] if destroy does not succeed.
    def destroy id_or_name, params={}
      delete "#{base_path}/#{id_or_name}.xml", params
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

