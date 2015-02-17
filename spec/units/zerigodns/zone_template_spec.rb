require 'spec_helper'

describe ZerigoDNS::ZoneTemplate do
  describe '#create_zone' do
    before :each do
      @template = ZerigoDNS::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
    end
    
    it 'creates a zone from the template' do
      expect(ZerigoDNS::Zone).to receive(:create).with(zone_template_id: 1, follow_template: 'follow', domain: 'zone-template-test.com')
      @template.create_zone(domain: 'zone-template-test.com')
    end
  end
  
  describe '#create_host_template' do
    before :each do
      @template = ZerigoDNS::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
    end
    
    it 'creates a host template' do
      expect(ZerigoDNS::HostTemplate).to receive(:create).with(zone_template_id: 1, host_type: 'A', hostname: 'www', data: '10.0.0.1')
      @template.create_host_template(host_type: 'A', hostname: 'www', data: '10.0.0.1')
    end
  end
  
  describe '.count' do
    it 'sends a GET request to the correct endpoint' do
      expect(described_class).to receive(:get).with('zone_templates/count.xml').and_return double(body: {'count' => '1'})
      described_class.count
    end
  end
  
  describe '#count_host_templates' do
    it 'sends a GET request to the correct endpoint' do
      @template = ZerigoDNS::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
      expect(@template).to receive(:get).with('zone_templates/1/host_templates/count.xml').and_return double(body: {'count' => '1'})
      @template.count_host_templates
    end
  end
  
  describe '#host_templates' do
    it 'sends the correct parameters to HostTemplate.find' do
      @template = ZerigoDNS::ZoneTemplate.new(id: 1, default_ttl: 900, custom_ns: false, ns_type: 'pri_sec')
      expect(ZerigoDNS::HostTemplate).to receive(:all).with(zone_template_id: 1)
      @template.host_templates
    end
  end
end
