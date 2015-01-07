require 'spec_helper'

describe 'Zone Template Management' do
  before :all do
    @domain = FeatureSpec.domain
    skip unless @domain
    @templates = []
  end
  
  after :all do
    @templates.each {|t| t.destroy rescue nil}
  end
  
  
  
  it 'creates a zone template' do
    @template = Zerigo::DNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test')
    @templates << @template
    expect {Zerigo::DNS::ZoneTemplate.find(@template.id)}.to_not raise_error
  end
  
  it 'creates a zone using the template' do
    @template = Zerigo::DNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-2')
    @templates << @template
    expect {Zerigo::DNS::ZoneTemplate.find(@template.id)}.to_not raise_error
    @domain = @template.create_zone(domain: 'zerigo-template-test.com')
    expect {Zerigo::DNS::Zone.find_by_domain 'zerigo-template-test.com'}.to_not raise_error
    @domain.destroy
  end
  
  it 'updates zone templates' do
    @template = Zerigo::DNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-3')
    @templates << @template
    @template.default_ttl = 1800
    @template.save
    changed_template=Zerigo::DNS::ZoneTemplate.find(@template.id)
    expect(changed_template.default_ttl).to eq 1800
  end
  
  it 'destroys a zone template' do
    @template = Zerigo::DNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-4')
    @template.destroy
    expect {Zerigo::DNS::ZoneTemplate.find(@template.id)}.to raise_error
  end
end
