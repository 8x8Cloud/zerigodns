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
      #      return true
      return true if @domain
      @user = YAML.load(File.read('spec/config/user.yml'))
      @user.each do |key, val|
        ZerigoDNS.config.send("#{key}=", val)
      end
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
    
    # Clean up resources from the feature test.
    def cleanup
      @domain.destroy
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
