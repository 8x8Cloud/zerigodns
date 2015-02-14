class ZerigoDNS::ZoneTemplate < ZerigoDNS::Client

  include ZerigoDNS::Resource
  
  # Get count of zone templates
  # @return [Fixnum] the count of zone templates
  def self.count
    get('zone_templates/count.xml').body['count'].to_i
  end
  
  # Get count of host templates
  # @return [Fixnum] the count of host templates for this zone template
  def count_host_templates
    get("zone_templates/#{id}/host_templates/count.xml").body['count'].to_i
  end
  
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
    ZerigoDNS::Zone.create({follow_template: 'follow', zone_template_id: id}.merge(attrs))
  end
  
  # List all host templates of this zone template
  # @return [Array] An array of host templates
  def host_templates
    @host_templates ||= ZerigoDNS::HostTemplate.all(zone_template_id: id)
  end
  
  # Create a host template for this template
  # @param [Hash, #read] attrs Attributes of the host template to be created
  def create_host_template attrs={}
    ZerigoDNS::HostTemplate.create(attrs.merge(zone_template_id: id))
  end
end
