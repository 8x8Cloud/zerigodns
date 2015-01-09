module Zerigo
  module DNS
    class Base < ActiveResource::Base
      class << self
        attr_reader :secure
        alias_method :api_key, :password
        alias_method :api_key=, :password=
        def secure=(bool)
          @secure=bool
          self.site = @secure ? 'https://ns.zerigo.com/api/1.1/' : 'http://ns.zerigo.com/api/1.1/'
        end
      end
      
      self.site='https://ns.zerigo.com/api/1.1/'
      self.timeout = 5 # timeout after 5 seconds
      self.format = ActiveResource::Formats::XmlFormat
      @secure = true
      
      
      
      # fix load() so that it no longer clobbers @prefix_options
      # also fix bug exposed by reload() where attributes is effectively parsed twice, causing the first line to raise an exception the 2nd time
      def load(attributes, remove_root = false)
        raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
        new_prefix_options, attributes = split_options(attributes)
        @prefix_options.merge!(new_prefix_options)
        attributes.each do |key, value|
          @attributes[key.to_s] =
            case value
            when Array
              if value.all?{|v2| v2.kind_of?(ActiveResource::Base)}
                value.dup rescue value
              else
                resource = find_or_create_resource_for_collection(key)
                value.map { |attrs| attrs.is_a?(String) ? attrs.dup : resource.new(attrs) }
              end
            when Hash
              resource = find_or_create_resource_for(key)
              resource.new(value)
            else
              value.dup rescue value
            end
        end
        self
      end
    end
  end
end
