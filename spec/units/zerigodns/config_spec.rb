require 'spec_helper'

describe ZerigoDNS::Config do
  
  before do
    @config = described_class.new
  end
  
  %w(api_key site secure user password).each do |attr|
    describe "#{attr}" do
      it "gets #{attr} from ZerigoDNS::Base" do
        expect(ZerigoDNS::Base).to receive(attr)
        @config.send(attr)
      end
    end
    
    describe "#{attr}=" do
      it "sets #{attr} on ZerigoDNS::Base" do
        expect(ZerigoDNS::Base).to receive("#{attr}=")
        @config.send("#{attr}=", "test")
      end
    end
  end
end 
