require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Product do
  context '.current_store' do
    it 'should call \'product.currentStore\' and return the ID' do
      Magento::Test.stub_service :method => 'product.currentStore',
        :arguments => [],
        :response => '123'

      Magento::Product.current_store.should == '123'
    end
  end

  context '.current_store=' do
    it 'should call \'product.currentStore\' with the specified store_view' do
      Magento::Test.stub_service :method => 'product.currentStore',
        :arguments => ['123'],
        :response => '123'

      Magento::Product.current_store = '123'
    end
  end

  context '.list' do
    it 'should call \'product.list\' with specified criteria and/or store_view and return an array of products' do
      Magento::Test.stub_service :method => 'product.list',
        :arguments => [{'name' => 'Movie Tickets'}, '123'],
        :response => [{'name' => 'Movie Tickets'}]

      products = Magento::Product.list(:name => 'Movie Tickets', :store_view => '123')
      products.first.should be_a Magento::Product
      products.first.name.should == 'Movie Tickets'
    end
  end

  context '.info' do
    it 'should call \'product.info\' with the specified resource ID and store_view and return a hash of attributes' do
      Magento::Test.stub_service :method => 'product.info',
        :arguments => ['123', '456'],
        :response => {'name' => 'Movie Tickets'}

      attributes = Magento::Product.info('123', :store_view => '456')
      attributes[:name].should == 'Movie Tickets'
    end
  end

  context '.create' do
    it 'should call \'product.create\' with specified type, attribute_set_id, sku and attributes and return a Product' do
      Magento::Test.stub_service :method => 'product.create',
        :arguments => ['special', '123', '456', {'name' => 'Movie Tickets'}],
        :response => '1'

      product = Magento::Product.create(:type => 'special', :attribute_set_id => '123', :sku => '456', :name => 'Movie Tickets')
      product.name.should == 'Movie Tickets'
    end
  end

  context '#update' do
    it 'should call \'product.update\' with the specified attributes' do
      Magento::Test.stub_service :method => 'product.update',
        :arguments => ['1', {'name' => 'Movie Tickets'}, '123'],
        :response => true

      product = Magento::Product.new(:product_id => '1', :name => 'Apparel')
      product.update :name => 'Movie Tickets', :store_view => '123'
      product.name.should == 'Movie Tickets'
    end
  end

  context '#delete' do
    it 'should call \'product.delete\' with the resource ID' do
      Magento::Test.stub_service :method => 'product.delete',
        :arguments => ['1'],
        :response => true

      product = Magento::Product.new(:product_id => '1')
      product.delete
    end
  end
end
