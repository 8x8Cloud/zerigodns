#
# Extra support methods for feature tests.
#
class FeatureSpec
  class <<self
    # A domain which can be used throughout the test suite.
    attr_reader :domain
    
    # Initializes the integration tests
    # @return [Boolean] true if successful, nil otherwise.
    def init
      return true if @domain
      load_config!
      @domain = ZerigoDNS::Zone.create(domain: 'zerigo-gem-testing.com', ns_type: 'pri_sec')
      true
    rescue Errno::ENOENT
      nil
    end
    
    # This should be called in a before :all hook on any feature spec.
    # @return [Boolean] true if the feature spec should run, false if not.
    def should_run?
      !!domain
    end
    
    # Load the config file.
    # @note may raise exceptions if the file cannot be found.
    def load_config!
      @user = YAML.load(File.read('spec/config/user.yml'))
      @user.each do |key, val|
        ZerigoDNS.config.send("#{key}=", val)
      end
    end
    
    # Clean up resources from the feature test.
    def cleanup
      # => Some tests change the config, this needs to be reloaded.
      load_config!
      @domain.destroy
    rescue Errno::ENOENT
      nil
    end
  end
end

RSpec.configure do |c|
  c.before :suite do
    FeatureSpec.init
  end
  c.after :suite do
    FeatureSpec.cleanup if FeatureSpec.domain
  end
end
