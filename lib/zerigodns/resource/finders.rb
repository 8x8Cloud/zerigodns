module Finders
  module InstanceMethods
    def update params
      self.class.update id, params
      @attributes.merge!(params)
    end
  end
  
  module ClassMethods
    def all params={}
      process_response get("#{base_path}.xml", params)
    end
    
    def find id_or_name, params={}
      process_response get("#{base_path}/#{id_or_name}.xml", params)
    end
    
    def update id_or_name, params={}
      process_response(put "#{base_path}/#{id_or_name}.xml", convert(params))
    end
    
    def create params={}
      process_response(post "#{base_path}.xml", convert(params))
    end
    
    def destroy
      delete "/api/1.1/#{self.class.base_path}/#{id_or_name}.xml", params
    end
    
    
    private
    
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

