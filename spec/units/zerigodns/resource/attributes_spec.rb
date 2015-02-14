require 'spec_helper'

describe ZerigoDNS::Resource::Attributes do
  before :each do
    @class = Class.new
    @class.send :include, ZerigoDNS::Resource::Attributes
    @instance = @class.new
  end
  
  describe '.from_response' do
    it 'builds a new object from the body' do
      result = @instance.class.from_response 'test', {a: 1}
      expect(result).to be_a @instance.class
      expect(result.a).to eq 1
    end
  end
  
  
  describe '#attr=' do
    context 'given invalid arguments' do
      it 'raises an error' do
        expect {@instance.send(:attr=, 1,2)}.to raise_error ArgumentError
      end
    end
    
    context 'given valid arguments' do
      it 'sets the attribute' do
        @instance.attr = 1
        expect(@instance.attributes).to eq 'attr' => 1
      end
    end
  end
  
  describe '#attr' do
    context 'given invalid arguments' do
      it 'raises an error' do
        expect {@instance.attr 'arg'}.to raise_error ArgumentError
      end
    end
    
    context 'given no arguments' do
      it 'returns the attribute value' do
        @instance.attributes['attr'] = 1
        expect(@instance.attr).to eq 1
      end
    end
  end
end
