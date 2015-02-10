require 'spec_helper'
require_relative '../features/feature_spec_helper'

describe 'Zone Template Management' do
  before :all do
    skip unless FeatureSpec.should_run?
    @domain = FeatureSpec.domain
    @templates = []
  end
  
  after :all do
    @templates.each {|t| t.destroy rescue nil}
  end
  
  
  
  it 'creates a zone template' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test')
    @templates << @template
    expect {ZerigoDNS::ZoneTemplate.find(@template.id)}.to_not raise_error
  end
  
  it 'creates a zone using the template' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-2')
    @templates << @template
    expect {ZerigoDNS::ZoneTemplate.find(@template.id)}.to_not raise_error
    @domain = @template.create_zone(domain: 'zerigo-template-test.com')
    expect {ZerigoDNS::Zone.find_by_domain 'zerigo-template-test.com'}.to_not raise_error
    @domain.destroy
  end
  
  it 'updates zone templates' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-3')
    @templates << @template
    @template.update default_ttl: 1800
    changed_template=ZerigoDNS::ZoneTemplate.find(@template.id)
    expect(changed_template.default_ttl).to eq 1800
  end
  
  it 'destroys a zone template' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-4')
    @template.destroy
    expect {ZerigoDNS::ZoneTemplate.find(@template.id)}.to raise_error
  end
  
  it 'counts zone templates' do
    expect(ZerigoDNS::ZoneTemplate.count).to be_a Fixnum
  end
  
  it 'counts host templates' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-5')
    @templates << @template
    expect(@template.count_host_templates).to be_a Fixnum
  end
  
  it 'lists all host templates' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-6')
    @host_template = @template.create_host_template(data: '10.10.10.10', hostname: 'www', host_type: 'A')
    @templates << @template
    expect(@template.host_templates).to be_a Array
    expect(@template.host_templates.count).to eq 1
  end
end
