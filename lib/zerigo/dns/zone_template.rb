require_relative 'base'
require_relative 'zone'

class Zerigo::DNS::ZoneTemplate < Zerigo::DNS::Base
  
  # Create a zone using the zone template
  # @param attrs Attributes of the zone to be created
  #   - domain [String]:  The domain name
  #   - follow_template [String] (default: 'follow'):
  #     * 'follow'  The zone will reflect updates made to the template.
  #     * 'no'  The zone will be a one-time copy of the template.
  #
  #   Due to a problem with XML conversion, the value assigned to follow_template must be a string and not a symbol.
  # @return [Zone] The created zone
  def create_zone attrs
    Zerigo::DNS::Zone.create({follow_template: 'follow', zone_template_id: id}.merge(attrs))
  end
end
