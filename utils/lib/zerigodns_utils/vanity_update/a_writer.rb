module ZerigoDNSUtils::VanityUpdate
  module AWriter
    
    
    # Provide cached DNS lookup for nameserver.
    # @param [String] data FQDN of nameserver.
    # @raise [StandardError] if lookup fails.  Also result is not cached if lookup failed.
    # @return [String] ip address of nameserver
    def self.lookup data
      @cache ||= {}
      
      @cache[data] ||= Resolv::DNS.new.getaddress(data).to_s.tap do |result|
        unless result && result.length > 0
          raise StandardError, "Could not get IP address for nameserver: #{data}.  Please try again."
        end
      end
    end
    def self.replace host, data
      newaddr = lookup(data)
      
      
      puts "Replace host #{host.fqdn} #{host.data} -> #{newaddr}"
      
      host.update(data: newaddr)
    end
  end
end
