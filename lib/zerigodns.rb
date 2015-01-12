# Copyright 2009 Zerigo, Inc.  See MIT-LICENSE for license information.
# Visit http://www.zerigo.com/docs/managed-dns for updates and documentation.
require 'activeresource-ext'
require 'zerigodns/base'
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
