require 'spec_helper'

describe ZerigoDNS::Middleware::ErrorHandler do
  describe '#call' do
    context 'given OK status code' do
      before :each do
        @client = Faraday.new do |builder|
          builder.response :custom_error_handler
          
          builder.adapter :test do |stub|
            stub.get('/test') {|env| [200, {'Content-Type' => 'text/xml'}, '<data>123</data>']}
          end
        end
      end
      
      it 'does not raise any error' do
        expect{@client.get('/test')}.to_not raise_error
      end
    end
    
    context 'given bad status code' do
      before :each do
        @client = Faraday.new do |builder|
          builder.response :custom_error_handler
          
          builder.adapter :test do |stub|
            stub.get('/test') {|env| [500, {'Content-Type' => 'text/xml'}, '<data>123</data>']}
          end
        end
      end
      
      it 'does raises an error' do
        expect{@client.get('/test')}.to raise_error ZerigoDNS::Client::ResponseError
      end
    end
    
  end
end
