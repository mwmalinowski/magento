require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Product do
  context '.current_store' do
    it 'should send \'product.currentStore\' to Magento and return the ID' do
      Magento::Test.stub_service :method => 'product.currentStore',
        :arguments => [],
        :response => '123'

      Magento::Product.current_store.should == '123'
    end
  end

  context '.current_store=' do
    it 'should send \'product.currentStore\' to Magento with the specified store_view' do
      Magento::Test.stub_service :method => 'product.currentStore',
        :arguments => ['123'],
        :response => '123'

      Magento::Product.current_store = '123'
    end
  end
end
