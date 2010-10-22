require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::StoreViewable do
  class TestStoreViewable
    include Magento::StoreViewable
  end

  context '.current_store' do
    it 'should send \'test_store_viewable.currentStore\' to Magento and return the ID' do
      Magento::Test.stub_service :method => 'test_store_viewable.currentStore',
        :arguments => [],
        :response => '123'

      TestStoreViewable.current_store.should == '123'
    end
  end

  context '.current_store=' do
    it 'should send \'test_store_viewable.currentStore\' to Magento with the specified store_view' do
      Magento::Test.stub_service :method => 'test_store_viewable.currentStore',
        :arguments => ['123'],
        :response => '123'

      TestStoreViewable.current_store = '123'
    end
  end
end
