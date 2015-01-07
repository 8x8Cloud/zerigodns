require 'spec_helper'

describe Zerigo::DNS::ZoneTemplate do
  describe '#create_zone' do
    before :each do
      @template = Zerigo::DNS::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
    end
    
    it 'creates a zone from the template' do
      expect(Zerigo::DNS::Zone).to receive(:create).with(zone_template_id: 1, follow_template: 'follow', domain: 'zone-template-test.com')
      @template.create_zone(domain: 'zone-template-test.com')
    end
  end
  
  describe '#create_host_template' do
    before :each do
      @template = Zerigo::DNS::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
    end
    
    it 'creates a host template' do
      expect(Zerigo::DNS::HostTemplate).to receive(:create).with(zone_template_id: 1, host_type: 'A', hostname: 'www', data: '10.0.0.1')
      @template.create_host_template(host_type: 'A', hostname: 'www', data: '10.0.0.1')
    end
  end
end
