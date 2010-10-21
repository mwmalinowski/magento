require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Savable do
  class TestSavable
    include Magento::Savable
  end

  context '#save' do
    it 'should send \'test_savable.create\' to Magento if the resource does not have an ID' do
      Magento::Test.stub_service :method => 'test_savable.create',
        :arguments => [{'email' => 'arothstein@example.com'}],
        :response => '1'

      resource = TestSavable.new(:email => 'arothstein@example.com')
      resource.save
    end

    it 'should send \'test_savable.update\' to Magento without the resource ID if it exists' do
      Magento::Test.stub_service :method => 'test_savable.update',
        :arguments => ['1', {'email' => 'arnoldr@example.com'}],
        :response => true

      resource = TestSavable.new(:test_savable_id => '1', :email => 'arothstein@example.com')
      resource.email = 'arnoldr@example.com'
      resource.save
    end
  end
end
