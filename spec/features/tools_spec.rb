require 'spec_helper'

describe 'Tools' do
  before :all do
    skip unless FeatureSpec.should_run?
  end
  it 'gets public ipv4' do
    expect(ZerigoDNS::Tools.public_ipv4).to be_a String
  end
  
  it 'gets public ipv6' do
    expect(ZerigoDNS::Tools.public_ipv6).to be_a String
  end
  
  it 'gets public ip' do
    expect(ZerigoDNS::Tools.public_ip).to be_a String
  end
end
