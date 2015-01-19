require 'spec_helper'

describe ZerigoDNS::HostTemplate do
  describe '#zone_template' do
    before :each do
      @host_template = described_class.new(zone_template_id: 1)
    end

    it 'gets the zone template' do
      expect(ZerigoDNS::ZoneTemplate).to receive(:find).with(1)
      @host_template.zone_template
    end
  end
end
