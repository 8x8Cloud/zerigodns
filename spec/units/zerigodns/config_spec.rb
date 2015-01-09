require 'spec_helper'

describe ZerigoDNS::Config do
  %w(api_key site secure user password).each do |attr|
    describe "#{attr}" do
      it "gets #{attr} from ZerigoDNS::Base" do
        expect(ZerigoDNS::Base).to receive(attr)
        described_class.send(attr)
      end
    end
    
    describe "#{attr}=" do
      it "sets #{attr} on ZerigoDNS::Base" do
        expect(ZerigoDNS::Base).to receive("#{attr}=")
        described_class.send("#{attr}=", "test")
      end
    end
  end
end 
