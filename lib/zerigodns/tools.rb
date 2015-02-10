class ZerigoDNS::Tools < ZerigoDNS::Client
  class <<self
    
    # Fetch current public ipv4 address
    # @return [String] Current public ipv4 address or "unknown"
    def public_ipv4
      get('tools/public_ipv4.xml').body['ipv4']
    end
    
    # Fetch current public ipv6 address
    # @return [String] Current public ipv6 address or "unknown"
    def public_ipv6
      get('tools/public_ipv6.xml').body['ipv6']
    end
    
    # Fetch the current public IP address (either ipv4 or ipv6)
    # @return [String] Current public ip address (ipv4 or ipv6)
    def public_ip
      get('tools/public_ip').body['ipv4'] || get('tools/public_ip').body['ipv6']
    end
  end

end
