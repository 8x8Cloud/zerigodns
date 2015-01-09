require 'spec_helper'

describe Zerigo::DNS::Tools do
  describe "#public_ipv4" do
    it 'sends a get request to the correct endpoint' do
      expect(described_class).to receive(:get).with(:public_ipv4)
      described_class.public_ipv4
    end
  end
  
  describe "#public_ipv6" do
    it 'sends a get request to the correct endpoint' do
      expect(described_class).to receive(:get).with(:public_ipv6)
      described_class.public_ipv6
    end
  end
  
  describe "#public_ip" do
    it 'sends a get request to the correct endpoint' do
      expect(described_class).to receive(:get).with(:public_ip)
      described_class.public_ip
    end
  end
end
