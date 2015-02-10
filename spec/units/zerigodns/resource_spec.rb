require 'spec_helper'

describe ZerigoDNS::Resource do
  before :each do
    @instance = Class.new.new
    @instance.class.send :include, described_class
  end
  
  describe '.base_path' do
    it 'sets & gets the base path' do
      @instance.class.send :base_path, 'classes'
      expect(@instance.class.base_path).to eq 'classes'
    end
  end
  
  describe 'resource_name' do
    it 'sets & gets the resource name' do
      @instance.class.send :base_path, 'class'
      expect(@instance.class.base_path).to eq 'class'
    end
  end
  
  describe '.process_array' do
    it 'converts an array of hashes into the resource' do
      allow(@instance.class).to receive(:from_response).and_return 1
      expect(@instance.class.process_array('1 2 3', [1,2,3])).to eq [1,1,1]
    end
  end
  
  describe '.process_response' do
    context 'given an array response' do
      
      before :each do
        @response = double(body: {classes: [{attr: 1}]})
      end
      
      it 'invokes process_array' do
        expect(@instance.class).to receive(:process_array).with(@response, [{attr: 1}])
        @instance.class.process_response @response
      end
    end
    
    context 'given a hash response' do
      before :each do
        @response = double(body: {class: {attr: 1}})
      end
      
      it 'delegates to from_response' do
        expect(@instance.class).to receive(:from_response).with(@response, {attr: 1})
        @instance.class.process_response @response
      end
    end
    
    context 'given something else' do
      it 'returns the result with the root removed' do
        
      end
    end
  end
end
