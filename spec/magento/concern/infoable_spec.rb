require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Infoable do
  class TestInfoable
    include Magento::Infoable
  end

  context '.info' do
    it 'should send \'customer.info\' to Magento and return a hash of attributes' do
      Magento::Test.stub_service :method => 'test_infoable.info',
        :arguments => ['1'],
        :response => {'test_infoable_id' => '1', 'firstname' => 'Arnold', 'lastname' => 'Rothstein', 'email' => 'arothstein@example.com'}

      attributes = TestInfoable.info('1')
      attributes[:firstname].should == 'Arnold'
    end
  end
end
