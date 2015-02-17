require 'spec_helper'

describe ZerigoDNS::Middleware::Xml do
  
  describe '#call' do
    
    context 'given valid XML' do
      before :each do
        @client = Faraday.new do |builder|
          builder.response :custom_xml
          
          builder.adapter :test do |stub|
            stub.get('/test') {|env| [200, {'Content-Type' => 'text/xml'}, '<data>123</data>']}
          end
        end
      end
      
      it 'parses the response data' do
        expect(@client.get('/test').body).to \
          eq 'data' => '123'
      end
      
      it 'exposes the raw data' do
        expect(@client.get('/test').env[:raw_body]).to \
          eq '<data>123</data>'
      end
    end
    
    context 'given not valid xml content type' do
      before :each do
        @client = Faraday.new do |builder|
          builder.response :custom_xml
          
          builder.adapter :test do |stub|
            stub.get('/test') {|env| [200, {}, '<data>123</data>']}
          end
        end
      end
      
      
      it 'skips conversion' do
        expect(@client.get('/test').body).to \
          eq '<data>123</data>'
      end
    end
    
    
    
    context 'given valid xml content type, but invalid data' do
      before :each do
        @client = Faraday.new do |builder|
          builder.response :custom_xml
          
          builder.adapter :test do |stub|
            stub.get('/test') {|env| [200, {'Content-Type' => 'text/xml'}, 'NOXMLHERE']}
          end
        end
      end
      
      
      it 'raises an error' do
        expect{@client.get('/test').body}.to raise_error
      end
    end
  end
end
