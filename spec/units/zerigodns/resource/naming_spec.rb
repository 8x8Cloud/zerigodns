require 'spec_helper'

describe ZerigoDNS::Resource::Naming do
  before :each do
    @instance = Class.new.new
    @instance.class.send :include, described_class
  end
  
  describe '.default_base_path' do
    it 'returns the class name underscored & pluralized' do
      allow(@instance.class).to receive(:to_s).and_return "Zone"
      expect(@instance.class.default_base_path).to eq 'zones'
    end
    
    it 'adapts to a changed resource name' do
      allow(@instance.class).to receive(:to_s).and_return "Zone"
      allow(@instance.class).to receive(:resource_name).and_return "domain"
      expect(@instance.class.default_base_path).to eq 'domains'
    end
  end

  describe '.default_resource_name' do
    it 'returns the class name underscored' do
      allow(@instance.class).to receive(:to_s).and_return "ZoneTemplate"
      expect(@instance.class.default_resource_name).to eq 'zone_template'
    end
  end
  
  
  describe '.base_path' do
    it 'defaults to the class name underscored & pluralized' do
      allow(@instance.class).to receive(:to_s).and_return "Zone"
      expect(@instance.class.base_path).to eq 'zones'
    end
    
    it 'sets & gets the base path' do
      @instance.class.send :base_path, 'classes'
      expect(@instance.class.base_path).to eq 'classes'
    end
  end
  
  describe 'resource_name' do
    it 'defaults to the class name underscored' do
      allow(@instance.class).to receive(:to_s).and_return "ZoneTemplate"
      expect(@instance.class.resource_name).to eq 'zone_template'
    end
    
    it 'sets & gets the resource name' do
      @instance.class.send :resource_name, 'class'
      expect(@instance.class.resource_name).to eq 'class'
    end
  end
end
