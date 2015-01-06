require 'spec_helper'

describe 'Zone Management' do
  before :all do
    @domain = FeatureSpec.domain
    skip unless @domain
  end
  
  it 'finds a zone' do
    expect{Zerigo::DNS::Zone.find_by_domain('zerigo-gem-testing.com')}.to_not raise_error
  end
  
  it 'creates a zone' do
    domain = Zerigo::DNS::Zone.create(domain: 'zerigo-gem-testing-2.com', ns_type: 'pri_sec')
    expect(domain.domain).to eq 'zerigo-gem-testing-2.com'
    expect{Zerigo::DNS::Zone.find('zerigo-gem-testing-2.com')}.to_not raise_error
    Zerigo::DNS::Zone.find('zerigo-gem-testing-2.com').destroy
  end
  
  it 'updates a zone' do
    @domain.default_ttl = 400
    @domain.save
    expect(Zerigo::DNS::Zone.find(@domain.id).default_ttl).to eq 400
  end
end