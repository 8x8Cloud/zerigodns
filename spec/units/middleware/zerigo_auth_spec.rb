require 'spec_helper'

describe ZerigoDNS::Middleware::ZerigoAuth do
  describe '#call' do
    before :each do
      
      ZerigoDNS.config.user = 'user'
      ZerigoDNS.config.api_key = 'pass'
      
      @client = Faraday.new do |builder|
        builder.request :zerigo_auth
        
        builder.adapter :test do |stub|
          stub.get('/test') {|env| [200, {'Content-Type' => 'text/xml'}, '<data>123</data>']}
        end
      end
    end
    
    
    let(:correct_auth) {'Basic dXNlcjpwYXNz'}
    
    
    it 'adds the correct header' do
      response = @client.get('/test')
      expect(response.env.request_headers['Authorization']).to eq correct_auth
    end
  end
end
