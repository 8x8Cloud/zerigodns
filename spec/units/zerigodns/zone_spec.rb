require 'spec_helper'

describe ZerigoDNS::Zone do
  
  describe '.count' do
    it 'calls the correct endpoint' do
      expect(described_class).to receive(:get).with('zones/count.xml').and_return double(body: {'count' => '1'})
      described_class.count
    end
  end
  
  describe '.find_by_domain' do
    it 'delegates to find' do
      expect(described_class).to receive(:find).with('domain.com')
      described_class.find_by_domain('domain.com')
    end
  end
  
  describe '.find_or_create' do
    context 'given a non-existant zone' do
      it 'creates the specified zone' do
        allow(described_class).to receive(:find).and_raise(ZerigoDNS::Client::ResponseError.new(double(code: double(not_found?: true))))
        expect(described_class).to receive(:create).with(domain: 'jackhq.com', ns_type: 'pri_sec')
        described_class.find_or_create('jackhq.com')
      end
    end
    
    context 'given an existing zone' do
      it 'returns the zone' do
        jackhq = double('ZerigoDNS::Zone')
        allow(jackhq).to receive(:domain).and_return('example.com')
        allow(described_class).to receive(:find).and_return(jackhq)
        expect(described_class).to_not receive(:create)
      end
    end
  end
  
  describe '#count_hosts' do
    it 'calls the correct endpoint' do
      @domain = described_class.new(id: 1)
      expect(@domain).to receive(:get).with('zones/1/hosts/count.xml').and_return double(body: {'count' => '1'})
      @domain.count_hosts
    end
  end
end
