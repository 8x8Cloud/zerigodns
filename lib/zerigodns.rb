# Copyright 2009 Zerigo, Inc.  See MIT-LICENSE for license information.
# Visit http://www.zerigo.com/docs/managed-dns for updates and documentation.
require 'faraday'
require 'multi_xml'
require 'zerigodns/client'
require 'zerigodns/client/response_code'

require 'zerigodns/middleware'
require 'zerigodns/middleware/xml'
require 'zerigodns/middleware/error_handler'

require 'zerigodns/resource'
require 'zerigodns/resource/finders'
require 'zerigodns/resource/attributes'
require 'zerigodns/config'
require 'zerigodns/host'
require 'zerigodns/zone'
require 'zerigodns/zone_template'
require 'zerigodns/host_template'
require 'zerigodns/tools'

module ZerigoDNS
  class <<self
    ## Instantiates and memoizes a new +Config+ object
    #
    # @return [Config] the cached configuration instance
    def config
      @config ||= Config.new
    end
    
    
    # Exposes a block with the +Config+ instance
    #
    # @yield [Config] the config instance
    def configure
      yield config
    end
  end
end
