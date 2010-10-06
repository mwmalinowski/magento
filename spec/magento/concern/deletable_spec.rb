require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Deletable do
  class TestDeletable
    include Magento::Deletable
  end

  context '#delete' do
    it 'should send \'customer.delete\' to Magento with the customer_id' do
      Magento::Test.stub_service :method => 'test_deletable.delete',
        :arguments => ['1'],
        :response => true

      customer = TestDeletable.new(:test_deletable_id => '1')
      customer.delete.should be_true
    end
  end
end
