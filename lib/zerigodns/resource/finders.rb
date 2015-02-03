module Finders
  module ClassMethods
    def all params={}
      self.class.process_response client.get("/api/1.1/#{self.class.base_path}.xml", params)
    end
    
    def find id_or_name, params={}
      self.class.process_response client.get("/api/1.1/#{self.class.base_path}/#{id_or_name}.xml", params)
    end
    
    def update id_or_name, params={}
      self.class.process_response(client.put "/api/1.1/#{self.class.base_path}/#{id_or_name}.xml", params)
    end
    
    def destroy
      client.delete "/api/1.1/#{self.class.base_path}/#{id_or_name}.xml", params
    end
  end
  
  def self.included includer
    includer.send :extend, ClassMethods
  end
end  

