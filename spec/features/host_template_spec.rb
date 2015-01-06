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
  
  it 'creates host templates' do
    @template = Zerigo::DNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test')
    @host_template = @template.create_host_template(data: '10.10.10.10', hostname: 'www', host_type: 'A')
    expect {Zerigo::DNS::HostTemplate.find(@host_template.id)}.to_not raise_error
    @template.destroy
  end
end
