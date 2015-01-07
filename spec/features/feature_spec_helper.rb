require 'spec_helper'
require 'zerigo_dns'
class FeatureSpec
  class <<self
    attr_reader :domain
    def init
      return true if @domain
      @user = YAML.load(File.read('spec/config/user.yml'))
      @user.each do |key, val|
        Zerigo::DNS::Base.send("#{key}=", val)
      end
      @domain = Zerigo::DNS::Zone.create(domain: 'zerigo-gem-testing.com', ns_type: 'pri_sec')
      true
    rescue Errno::ENOENT
      nil
    end
    
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
