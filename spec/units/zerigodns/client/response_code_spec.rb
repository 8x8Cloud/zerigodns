require 'spec_helper'
describe ZerigoDNS::Client::ResponseCode do
  describe '#ok?' do
    context 'raw code is in range 200..299' do
      before :each do
        @code = described_class.new(201)
      end
      it 'returns true' do
        expect(@code).to be_ok
      end
    end
    
    context 'raw code is out of range 200..299' do
      before :each do
        @code = described_class.new(300)
      end
      it 'returns false' do
        expect(@code).to_not be_ok
      end
    end
  end
  
  
  describe '#server_error?' do
    context 'raw code is 500' do
      before :each do
        @code = described_class.new(500)
      end
      it 'returns true' do
        expect(@code).to be_server_error
      end
    end
    
    context 'raw code is not 500' do
      before :each do
        @code = described_class.new(404)
      end
      it 'returns false' do
        expect(@code).to_not be_server_error
      end
    end
  end
  
  describe '#error?' do
    context 'raw code is not 200..299' do
      before :each do
        @code = described_class.new(404)
      end
      it 'returns true' do
        expect(@code).to be_error
      end
    end
    
    context 'raw code is 200..299' do
      before :each do
        @code = described_class.new(200)
      end
      it 'returns false' do
        expect(@code).to_not be_error
      end
    end
  end
  
  
  describe '#not_found?' do
    context 'raw code is 404' do
      before :each do
        @code = described_class.new(404)
      end
      it 'returns true' do
        expect(@code).to be_not_found
      end
    end
    
    context 'raw code is not 500' do
      before :each do
        @code = described_class.new(500)
      end
      it 'returns false' do
        expect(@code).to_not be_not_found
      end
    end
  end
end
