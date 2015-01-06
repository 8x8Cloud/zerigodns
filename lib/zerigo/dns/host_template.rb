require_relative 'base'
require_relative 'zone_template'

class Zerigo::DNS::HostTemplate < Zerigo::DNS::Base
  
  # Fetches the zone template to which the host template belongs.
  # @return [ZoneTemplate] The zone template to which the host template belongs.
  # @raise [ActiveResource::ResourceNotFound] if the zone template does not exist.
  def zone_template
    @zone_template ||= Zerigo::DNS::ZoneTemplate.find(zone_template_id)
  end
end
