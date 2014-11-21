require File.dirname(__FILE__) + '/../spec_helper'

describe "Zerigo::DNS::Host.update_or_create" do
  
  before :each do
    @domain = double('Zerigo::DNS::Domain')
    @domain.stub(:id).and_return(1)
    @domain.stub(:domain).and_return('domain.com')
    
  end
  
  it 'should create host' do
    Zerigo::DNS::Host.stub(:find).and_return([])
    Zerigo::DNS::Host.stub(:create).and_return(:success => true)
    
    Zerigo::DNS::Host.update_or_create(@domain, 'www', 'A', '10.10.10.10', 86400)[:success].should eq true
  end

  it 'should update host' do
    jackhq = double('Zerigo::DNS::Host')
    jackhq.stub(:hostname).and_return('www')
    jackhq.stub(:host_type=)
    jackhq.stub(:data=)
    jackhq.stub(:ttl=)
    jackhq.stub(:save).and_return(true)
    jackhq.stub(:update_record).and_return true
    
    Zerigo::DNS::Host.stub(:find).and_return([jackhq])
    Zerigo::DNS::Host.stub(:create).and_return(:success => false)
    
    Zerigo::DNS::Host.update_or_create(@domain, 'www', 'A', '10.10.10.10', 86499).hostname == 'www'
  end

  it 'should find by zone and host' do
    jackhq = double('Zerigo::DNS::Host')
    jackhq.stub(:hostname).and_return('www')
    Zerigo::DNS::Host.stub(:find).and_return([jackhq])
    Zerigo::DNS::Host.find_first_by_hostname(@domain, 'www').hostname == 'www'
  end
end
