require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Findable do
  class TestFindable
    include Magento::Findable
  end

  context '.find' do
    it 'should send \'test_findable.info\' to Magento and return a TestFindable object' do
      Magento::Test.stub_service :method => 'test_findable.info',
        :arguments => ['1'],
        :response => {'test_findable_id' => '1', 'firstname' => 'Arnold', 'lastname' => 'Rothstein', 'email' => 'arothstein@example.com'}

      customer = TestFindable.find('1')
      customer.should be_a TestFindable
      customer.firstname.should == 'Arnold'
    end
  end
end
