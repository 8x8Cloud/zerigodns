class ZerigoDNS::Zone < ZerigoDNS::Base
  class <<self
    # Get count of all zones
    # @return [Fixnum] Count of all zones
    def count
      get(:count).to_i
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
    rescue ActiveResource::ResourceNotFound
      create(:domain=> domain, :ns_type=>'pri_sec')
    end
  end
  
  # Get count of all hosts belonging to this zone
  # @return [Fixnum] Count of all hosts belonging to this zone.
  def count_hosts
    get('hosts/count').to_i
  end
end
