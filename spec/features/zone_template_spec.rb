require 'spec_helper'

describe 'Zone Template Management' do
  before :all do
    @domain = FeatureSpec.domain
    skip unless @domain
  end
  
  it 'creates a zone template' do
    @template = Zerigo::DNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test')
    expect {Zerigo::DNS::ZoneTemplate.find(@template.id)}.to_not raise_error
    @template.destroy
  end
  
  it 'creates a zone using the template' do
    @template = Zerigo::DNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-2')
    expect {Zerigo::DNS::ZoneTemplate.find(@template.id)}.to_not raise_error
    @domain = @template.create_zone(domain: 'zerigo-template-test.com')
    expect {Zerigo::DNS::Zone.find_by_domain 'zerigo-template-test.com'}.to_not raise_error
    @domain.destroy
    @template.destroy
  end
  
  it 'destroys a zone template' do
    @template = Zerigo::DNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-3')
    @template.destroy
    expect {Zerigo::DNS::ZoneTemplate.find(@template.id)}.to raise_error
  end
end
