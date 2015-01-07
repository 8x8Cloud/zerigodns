require_relative 'base'

class Zerigo::DNS::Tools < Zerigo::DNS::Base
  class <<self
    
    # Fetch current public ipv4 address
    # @return [String] Current public ipv4 address or "unknown"
    def public_ipv4
      get :public_ipv4
    end
    
    # Fetch current public ipv6 address
    # @return [String] Current public ipv6 address or "unknown"
    def public_ipv6
      get :public_ipv6
    end
  end

end
