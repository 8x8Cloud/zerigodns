require_relative 'base'

class Zerigo::DNS::Zone < Zerigo::DNS::Base
  class <<self
    # Find zone by domain name
    # @param [String, #read] domain the domain to retrieve
    # @return [Zone] the domain retrieved.  nil if no domain
    def find_by_domain(domain)
      find(domain)
    end
    
    # Find or Create Zone
    # @param [String, #read] domain name of domain to create
    # @return [Zone] the zone found or created.
    def find_or_create(domain)
      zone = find_by_domain(domain)
      unless zone
        zone = create(:domain=> domain, :ns_type=>'pri_sec')
      end  
      zone
    end
  end
end
