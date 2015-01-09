require 'spec_helper'

describe 'Zone Management' do
  before :all do
    @domain = FeatureSpec.domain
    skip unless @domain
  end
  
  it 'finds a zone' do
    expect{ZerigoDns::Zone.find_by_domain('zerigo-gem-testing.com')}.to_not raise_error
  end
  
  it 'creates and destroys a zone' do
    domain = ZerigoDns::Zone.create(domain: 'zerigo-gem-testing-2.com', ns_type: 'pri_sec')
    expect(domain.domain).to eq 'zerigo-gem-testing-2.com'
    expect{ZerigoDns::Zone.find('zerigo-gem-testing-2.com')}.to_not raise_error
    ZerigoDns::Zone.find('zerigo-gem-testing-2.com').destroy
    expect{ZerigoDns::Zone.find('zerigo-gem-testing-2.com')}.to raise_error
  end
  
  it 'updates a zone' do
    @domain.default_ttl = 400
    @domain.save
    expect(ZerigoDns::Zone.find(@domain.id).default_ttl).to eq 400
  end
  
  it 'counts the zones' do
    expect(ZerigoDns::Zone.count).to be_a Fixnum
  end
  
  it 'counts the hosts' do
    expect(@domain.count_hosts).to be_a Fixnum
  end
end
