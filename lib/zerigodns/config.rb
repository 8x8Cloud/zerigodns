module ZerigoDNS
  class Config
    # These attributes need to be set on ZerigoDNS::Base for activeresource to work properly.
    BASE_ATTRIBUTES = %w(api_key site secure user password)
    class <<self
      BASE_ATTRIBUTES.each do |attr|
        define_method attr do
          ZerigoDNS::Base.send(attr)
        end
        
        define_method "#{attr}=" do |val|
          ZerigoDNS::Base.send("#{attr}=", val)
        end
      end
    end
  end
end
