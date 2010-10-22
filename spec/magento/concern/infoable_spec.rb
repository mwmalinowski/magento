require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Infoable do
  class TestInfoable
    include Magento::Infoable
  end

  context '.info' do
    it 'should send \'test_infoable.info\' to Magento and return a hash of attributes' do
      Magento::Test.stub_service :method => 'test_infoable.info',
        :arguments => ['1'],
        :response => {'test_infoable_id' => '1', 'firstname' => 'Arnold', 'lastname' => 'Rothstein', 'email' => 'arothstein@example.com'}

      attributes = TestInfoable.info('1')
      attributes[:firstname].should == 'Arnold'
    end

    it 'should call \'test_infoable.info\' with ID and store_view, if specified' do
      Magento::Test.stub_service :method => 'test_infoable.info',
        :arguments => ['1', '123'],
        :response => {'email' => 'arothstein@example.com'}

      TestInfoable.info '1', :store_view => '123'
    end

    it 'should call \'test_infoable.info\' with ID, file and store_view, if specified' do
      Magento::Test.stub_service :method => 'test_infoable.info',
        :arguments => ['1', 'thumb', '123'],
        :response => {'email' => 'arothstein@example.com'}

      TestInfoable.info '1', :file => 'thumb', :store_view => '123'
    end
  end
end
