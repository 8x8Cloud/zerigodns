require 'spec_helper'

describe ZerigoDNS::Resource::Finders do
  before :each do
    @class = Class.new 
    @class.send :include, ZerigoDNS::Resource
    allow(@class).to receive(:base_path).and_return 'classes'
    allow(@class).to receive(:resource_name).and_return 'class'
  end
  
  
  describe '.all' do
    
    before :each do
      @response = double(body: {'classes' => [{'attr' => 1}]})
      allow(@class).to receive(:get).with('classes.xml', {}).and_return @response
    end
    
    it 'gets all of the resource' do
      expect(@class).to receive(:process_response).with(@response)
      @class.all
    end
  end
  
  describe '.find' do
    before :each do
      @response = double(body: {'class' => {'attr' => 1}})
      allow(@class).to receive(:get).with('classes/1.xml', {}).and_return @response
    end
    
    it 'finds a specific resource' do
      expect(@class).to receive(:process_response).with(@response)
      @class.find 1
    end
  end
  
  describe '.update' do
    before :each do
      allow(@class).to receive(:put).with('classes/1.xml', 'class' => {'attr' => 1}).and_return @response
    end
    
    it 'updates attributes' do
      @class.update 1, 'attr' => 1
    end
    
    it 'updates attributes with an object' do
      instance = @class.new
      allow(instance).to receive(:to_hash).and_return 'attr' => 1
      @class.update 1, instance
    end
  end
  
  
  describe '.create' do
    before :each do
      @response = double(body: {'class' => {'attr' => 1}})
      allow(@class).to receive(:post).with('classes.xml', 'class' => {'attr' => 1}).and_return @response
    end
    
    it 'posts a new object' do
      expect(@class).to receive(:process_response).with(@response)
      @class.create 'attr' => 1
    end
  end
  
  describe '.destroy' do
    before :each do
      @response = double(body: {'class' => {'attr' => 1}})
    end
    
    it 'deletes the object' do
      expect(@class).to receive(:delete).with('classes/1.xml', {}).and_return @response
      @class.destroy 1
    end
  end
  
  
  describe '#update' do
    it 'updates the attributes' do
      expect(@class).to receive(:put).with('classes/1.xml', 'class' => {'attr' => 1})
      instance = @class.new id: 1
      instance.update 'attr' => 1
      expect(instance.attr).to eq 1
    end
  end
  
  describe '#destroy' do
    it 'deletes the resource' do
      expect(@class).to receive(:delete).with('classes/1.xml', {})
      instance = @class.new id: 1
      instance.destroy
    end
  end
end
