class Zerigo::DNS::ZoneTemplate < Zerigo::DNS::Base
  
  # Create a zone using the zone template
  # @param [Hash, #read] attrs Attributes of the zone to be created
  # @option attrs domain [String, #read] The domain name
  # @option attrs follow_template [String, #read] ('follow')
  #   * 'follow'  The zone will reflect updates made to the template.
  #   * 'no'  The zone will be a one-time copy of the template.
  # 
  #   Due to a problem with XML conversion, the value assigned to follow_template must be a string and not a symbol.
  # @return [Zone] The created zone
  def create_zone attrs
    Zerigo::DNS::Zone.create({follow_template: 'follow', zone_template_id: id}.merge(attrs))
  end
  
  
  # Create a host template for this template
  # @param [Hash, #read] attrs Attributes of the host template to be created
  def create_host_template attrs={}
    Zerigo::DNS::HostTemplate.create(attrs.merge(zone_template_id: id))
  end
end
