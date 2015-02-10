require 'spec_helper'
require_relative '../features/feature_spec_helper'

describe 'Host Template Management' do
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
  
  it 'creates host templates' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-2')
    @templates << @template
    @host_template = @template.create_host_template(data: '10.10.10.10', hostname: 'www', host_type: 'A')
    expect {ZerigoDNS::HostTemplate.find(@host_template.id)}.to_not raise_error

  end
  
  it 'updates host templates' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-3')
    @templates << @template
    @host_template = @template.create_host_template(data: '10.10.10.10', hostname: 'www', host_type: 'A')
    @host_template.update ttl: 86400
    expect(ZerigoDNS::HostTemplate.find(@host_template.id).ttl).to eq 86400
  end
  
  it 'deletes a host template' do
    @template = ZerigoDNS::ZoneTemplate.create(custom_ns: false, default_ttl: 900, ns_type: 'pri_sec', name: 'gem-test-4')
    @templates << @template
    @host_template = @template.create_host_template(data: '10.10.10.10', hostname: 'www', host_type: 'A')
    expect {ZerigoDNS::HostTemplate.find(@host_template.id)}.to_not raise_error
    @host_template.destroy
    expect {ZerigoDNS::HostTemplate.find(@host_template.id)}.to raise_error
  end
end
