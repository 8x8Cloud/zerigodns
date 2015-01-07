require_relative 'base'

class Zerigo::DNS::Tools < Zerigo::DNS::Base
  class <<self
    def public_ipv4
      get :public_ipv4
    end
    
    def public_ipv6
      get :public_ipv6
    end
  end

end
