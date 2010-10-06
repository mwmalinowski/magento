require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Listable do
  class TestListable
    include Magento::Listable
  end

  context '.list' do
    it 'should send \'customer.list\' to Magento and return an array of Customer objects' do
      Magento::Test.stub_service :method => 'test_listable.list',
        :arguments => [{'lastname' => 'Rothstein'}],
        :response => [{'test_listable_id' => '1', 'firstname' => 'Arnold', 'lastname' => 'Rothstein'}]

      customers = TestListable.list(:lastname => 'Rothstein')
      customers.first.should be_a TestListable
      customers.first.firstname.should == 'Arnold'
    end
  end
end
