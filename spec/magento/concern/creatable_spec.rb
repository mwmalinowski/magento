require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Creatable do
  class TestCreatable
    include Magento::Creatable
  end

  context '.create' do
    it 'should send \'customer.create\' to Magento and return a Customer object' do
      Magento::Test.stub_service :method => 'test_creatable.create',
        :arguments => [{'firstname' => 'Arnold', 'lastname' => 'Rothstein', 'email' => 'arothstein@example.com'}],
        :response => '1'

      customer = TestCreatable.create(:firstname => 'Arnold', :lastname => 'Rothstein', :email => 'arothstein@example.com')
      customer.should be_a TestCreatable
      customer.lastname.should == 'Rothstein'
    end
  end
end
