require 'spec_helper'

describe ZerigoDNS::Config do
  
  before do
    @config = described_class.new
  end
  
  %w(api_key site secure user).each do |attr|
    it "responds to #{attr}" do
      expect(@config).to respond_to attr
    end
    
    it "responds to #{attr}=" do
      expect(@config).to respond_to "#{attr}="
    end
  end
end 
