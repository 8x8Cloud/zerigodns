require 'spec_helper'

describe ZerigoDns::ZoneTemplate do
  describe '#create_zone' do
    before :each do
      @template = ZerigoDns::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
    end
    
    it 'creates a zone from the template' do
      expect(ZerigoDns::Zone).to receive(:create).with(zone_template_id: 1, follow_template: 'follow', domain: 'zone-template-test.com')
      @template.create_zone(domain: 'zone-template-test.com')
    end
  end
  
  describe '#create_host_template' do
    before :each do
      @template = ZerigoDns::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
    end
    
    it 'creates a host template' do
      expect(ZerigoDns::HostTemplate).to receive(:create).with(zone_template_id: 1, host_type: 'A', hostname: 'www', data: '10.0.0.1')
      @template.create_host_template(host_type: 'A', hostname: 'www', data: '10.0.0.1')
    end
  end
  
  describe '.count' do
    it 'sends a GET request to the correct endpoint' do
      expect(described_class).to receive(:get).with(:count)
      described_class.count
    end
  end
  
  describe '#count_host_templates' do
    it 'sends a GET request to the correct endpoint' do
      @template = ZerigoDns::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
      expect(@template).to receive(:get).with('host_templates/count')
      @template.count_host_templates
    end
  end
  
  describe '#host_templates' do
    it 'sends the correct parameters to HostTemplate.find' do
      @template = ZerigoDns::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
      expect(ZerigoDns::HostTemplate).to receive(:find).with(:all, params: {zone_template_id: 1})
      @template.host_templates
    end
  end
end
