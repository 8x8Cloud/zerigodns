require 'spec_helper'

describe ZerigoDNS do
  describe '#config' do
    it 'returns an instance of ZerigoDNS::Config' do
      expect(ZerigoDNS.config).to be_a ZerigoDNS::Config
    end
  end
  
  describe '#configure' do
    it 'yields ZerigoDNS.config' do
      expect { |b|
        ZerigoDNS.configure &b
      }.to yield_with_args(ZerigoDNS.config)
    end
  end
end
