require 'spec_helper'

describe Zerigo::DNS::Host do
  
  before :each do
    @domain = double('Zerigo::DNS::Domain')
    allow(@domain).to receive(:id).and_return(1)
    allow(@domain).to receive(:domain).and_return('domain.com')
  end
  
  describe '#find_all_by_hostname' do
    it 'sends the correct arguments to find' do
      expect(described_class).to receive(:find).with(:all, params: {fqdn: "host.domain.com", zone_id: 1})
      described_class.find_all_by_hostname(@domain, 'host')
    end
  end
  
  describe '#find_first_by_hostname' do
    it 'sends the correct arguments to find' do
      expect(described_class).to receive(:find).with(:all, params: {fqdn: "host.domain.com", zone_id: 1})
      described_class.find_first_by_hostname(@domain, 'host')
    end
    
    it 'takes the first element from the resulting array' do
      allow(described_class).to receive(:find).and_return([1,2,3])
      expect(described_class.find_first_by_hostname(@domain, 'host')).to eq 1
    end
  end
  
  describe '#update_record' do
    it 'updates the correct attributes' do
      @host = Zerigo::DNS::Host.new
      expect(@host).to receive(:save).and_return true
      @host.update_record('A', 900, '10.0.0.1')
      expect([@host.host_type, @host.data, @host.ttl]).to eq ['A', '10.0.0.1', 900]
    end
  end
  
  describe '#update_or_create' do
    context 'given a non-existent host' do
      it 'creates a host record' do
        allow(described_class).to receive(:find).and_return([])
        expect(described_class).to receive(:create).with(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
        described_class.update_or_create(@domain, 'www', 'A', 86400, '10.10.10.10')
      end
    end
    
    context 'given an existing host record' do
      it 'updates the host record' do
        jackhq = double('Zerigo::DNS::Host')
        allow(jackhq).to receive(:hostname).and_return('www')
        allow(jackhq).to receive(:host_type=)
        allow(jackhq).to receive(:data=)
        allow(jackhq).to receive(:ttl=)
        allow(jackhq).to receive(:save).and_return(true)
        allow(jackhq).to receive(:update_record).and_return true
        
        allow(described_class).to receive(:find).and_return([jackhq])
        expect(described_class).to_not receive(:create)
        
        described_class.update_or_create(@domain, 'www', 'A', '10.10.10.10', 86499)
      end
    end
  end
end
