module ZerigoDNSUtils::VanityUpdate
  class SomeDomainsFinder
    def initialize domain_list
      @list = domain_list
    end
    
    def each_zone
      @list.each do |domain|
        yield ZerigoDNS::Zone.find_by_domain(domain)
      end
    end
  end
end
