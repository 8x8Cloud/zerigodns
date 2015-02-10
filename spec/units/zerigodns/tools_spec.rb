require 'spec_helper'

describe ZerigoDNS::Tools do
  describe "#public_ipv4" do
    it 'sends a get request to the correct endpoint' do
      expect(described_class).to receive(:get).with('tools/public_ipv4.xml').and_return double(body: {'ipv4' => '1.2.3.4'})
      described_class.public_ipv4
    end
  end
  
  describe "#public_ipv6" do
    it 'sends a get request to the correct endpoint' do
      expect(described_class).to receive(:get).with('tools/public_ipv6.xml').and_return double(body: {'ipv6' => '::::'})
      described_class.public_ipv6
    end
  end
  
  describe "#public_ip" do
    it 'sends a get request to the correct endpoint' do
      expect(described_class).to receive(:get).with('tools/public_ip').and_return double(body: {'ipv4' => '1.2.3.4'})
      described_class.public_ip
    end
  end
end
