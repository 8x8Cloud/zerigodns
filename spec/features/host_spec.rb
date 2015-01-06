require 'spec_helper'

describe 'Host Management' do
  before :all do
    @domain = FeatureSpec.domain
    skip unless @domain
  end
  
  it 'creates a host record' do
    @host = Zerigo::DNS::Host.create(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
    expect{Zerigo::DNS::Host.find(@host.id)}.to_not raise_error
    @host.destroy
  end
  
  it 'finds a host by hostname' do
    @host = Zerigo::DNS::Host.create(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
    expect(Zerigo::DNS::Host.find_all_by_hostname(@domain, 'www').count).to be > 0
  end
  
  it 'updates a host record' do
    @host = Zerigo::DNS::Host.create(zone_id: @domain.id, hostname: 'www', host_type: 'A', ttl: 86400, data: '10.10.10.10')
    @host.update_record 'A', 900, '10.10.10.1'
    @host = Zerigo::DNS::Host.find(@host.id)
    expect(@host.ttl).to eq 900
    expect(@host.data).to eq '10.10.10.1'
    @host.destroy
  end
end
