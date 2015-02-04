class ZerigoDNS::Zone < ZerigoDNS::Client
  include ZerigoDNS::Resource

  resource_name 'zone'
  base_path 'zones'
  
  class <<self
    
    # Get count of all zones
    # @return [Fixnum] Count of all zones
    def count
      get('zones/count').body['count'].to_i
    end
    
    # Find zone by domain name
    # @param [String, #read] domain the domain to retrieve
    # @raise ActiveResource::ResourceNotFound if the domain is not present.
    # @return [Zone] the domain retrieved.
    def find_by_domain(domain)
      find(domain)
    end
    
    # Find or Create Zone
    # @param [String, #read] domain name of domain to create
    # @return [Zone] the zone found or created.
    def find_or_create(domain)
      find_by_domain(domain)
    rescue ZerigoDNS::Client::ResponseError => e
      raise unless e.response.code.not_found?
      create(:domain=> domain, :ns_type=>'pri_sec')
    end
  end
  
  # Get count of all hosts belonging to this zone
  # @return [Fixnum] Count of all hosts belonging to this zone.
  def count_hosts
    get('zones/hosts/count').body['count'].to_i
  end
end
