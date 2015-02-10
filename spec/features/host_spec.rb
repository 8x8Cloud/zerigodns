require 'spec_helper'

describe 'Host Management' do
  before :all do
    skip unless FeatureSpec.should_run?
    @domain = FeatureSpec.domain
  end
  
  it 'creates and destroys a host record' do
    @host = ZerigoDNS::Host.create(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
    expect{ZerigoDNS::Host.find(@host.id)}.to_not raise_error
    @host.destroy
    expect{ZerigoDNS::Host.find(@host.id)}.to raise_error
  end
  
  it 'finds all hosts by hostname' do
    @host = ZerigoDNS::Host.create(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
    expect(ZerigoDNS::Host.find_all_by_hostname(@domain, 'www').count).to be > 0
    @host.destroy
  end
  
  it 'finds a single host by hostname' do
    @host = ZerigoDNS::Host.create(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
    expect(ZerigoDNS::Host.find_first_by_hostname(@domain, 'www')).to_not be_nil
    @host.destroy
  end
  
  it 'updates a host record' do
    @host = ZerigoDNS::Host.create(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
    @host.update host_type: 'A', ttl: 900, data: '10.10.10.1'
    @host = ZerigoDNS::Host.find(@host.id)
    expect(@host.ttl).to eq 900
    expect(@host.data).to eq '10.10.10.1'
    @host.destroy
  end
end
