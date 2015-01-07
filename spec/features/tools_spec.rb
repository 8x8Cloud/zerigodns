require 'spec_helper'

describe 'Tools' do
  it 'gets public ipv4' do
    expect(Zerigo::DNS::Tools.public_ipv4).to be_a String
  end
  
  it 'gets public ipv6' do
    expect(Zerigo::DNS::Tools.public_ipv6).to be_a String
  end
  
  it 'gets public ip' do
    expect(Zerigo::DNS::Tools.public_ip).to be_a String
  end
end
