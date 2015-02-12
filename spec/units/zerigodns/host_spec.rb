require 'spec_helper'

describe ZerigoDNS::Host do
  
  before :each do
    @domain = double('ZerigoDNS::Domain')
    allow(@domain).to receive(:id).and_return(1)
    allow(@domain).to receive(:domain).and_return('domain.com')
  end
  
  describe '#find_by_zone_and_hostname' do
    
    before :each do
      allow(ZerigoDNS::Host).to receive(:find_all_by_hostname).and_return [1,2,3]
    end
    
    context 'which is :all' do
      it 'returns all records' do
        expect(ZerigoDNS::Host.find_by_zone_and_hostname :all, @domain, 'domain.com').to eq [1,2,3]
      end
    end
    
    context 'which is :first' do
      it 'returns the first record' do
        expect(ZerigoDNS::Host.find_by_zone_and_hostname :first, @domain, 'domain.com').to eq 1
      end
    end
    
    context 'which is :last' do
      it 'returns the last record' do
        expect(ZerigoDNS::Host.find_by_zone_and_hostname :last, @domain, 'domain.com').to eq 3
      end
    end
  end
  
  
  describe '#find_all_by_hostname' do
    it 'sends the correct arguments to find' do
      expect(described_class).to receive(:all).with(fqdn: "host.domain.com", zone_id: 1).and_return []
      described_class.find_all_by_hostname(@domain, 'host')
    end
  end
  
  describe '#find_first_by_hostname' do
    it 'sends the correct arguments to find' do
      expect(described_class).to receive(:all).with(fqdn: "host.domain.com", zone_id: 1).and_return []
      described_class.find_first_by_hostname(@domain, 'host')
    end
    
    it 'takes the first element from the resulting array' do
      allow(described_class).to receive(:all).and_return([1,2,3])
      expect(described_class.find_first_by_hostname(@domain, 'host')).to eq 1
    end
  end
  
  describe '#update_or_create' do
    context 'given a non-existent host' do
      it 'creates a host record' do
        allow(described_class).to receive(:all).and_return([])
        expect(described_class).to receive(:create).with(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
        described_class.update_or_create(@domain, 'www', 'A', 86400, '10.10.10.10')
      end
    end
    
    context 'given an existing host record' do
      it 'updates the host record' do
        jackhq = double('ZerigoDNS::Host')
        allow(jackhq).to receive(:update).and_return true
        
        allow(described_class).to receive(:all).and_return([jackhq])
        expect(described_class).to_not receive(:create)
        
        described_class.update_or_create(@domain, 'www', 'A', '10.10.10.10', 86499)
      end
    end
  end
end
