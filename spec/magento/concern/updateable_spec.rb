require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Updatable do
  class TestUpdatable
    include Magento::Updatable
  end

  context '#update' do
    it 'should send \'test_updatable.update\' to Magento with the specified attributes' do
      Magento::Test.stub_service :method => 'test_updatable.update',
        :arguments => ['1', {'email' => 'arnoldr@example.com'}],
        :response => true

      resource = TestUpdatable.new(:test_updatable_id => '1', :email => 'arothstein@example.com')
      resource.update(:email => 'arnoldr@example.com')
      resource.email.should == 'arnoldr@example.com'
    end
  end
end
