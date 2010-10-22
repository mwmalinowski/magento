require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Reloadable do
  class TestReloadable
    include Magento::Reloadable
  end

  context '#update' do
    it 'should call \'test_reloadable.info\' with the specified ID and update the resource\'s attribute values' do
      Magento::Test.stub_service :method => 'test_reloadable.info',
        :arguments => ['1'],
        :response => {'email' => 'arothstein@example.com'}

      resource = TestReloadable.new(:test_reloadable_id => '1')
      resource.reload
      resource.email.should == 'arothstein@example.com'
    end

    it 'should call \'test_reloadable.info\' with ID and store_view, if specified' do
      Magento::Test.stub_service :method => 'test_reloadable.info',
        :arguments => ['1', '123'],
        :response => {'email' => 'arothstein@example.com'}

      resource = TestReloadable.new(:test_reloadable_id => '1')
      resource.reload :store_view => '123'
    end

    it 'should call \'test_reloadable.info\' with ID, file and store_view, if specified' do
      Magento::Test.stub_service :method => 'test_reloadable.info',
        :arguments => ['1', 'thumb', '123'],
        :response => {'email' => 'arothstein@example.com'}

      resource = TestReloadable.new(:test_reloadable_id => '1')
      resource.reload :file => 'thumb', :store_view => '123'
    end
  end
end
