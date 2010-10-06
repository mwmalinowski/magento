require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Resource do
  class TestResourceA
    include Magento::Resource
  end

  class TestResourceB
    include Magento::Resource

    def self.resource_name
      'test_two'
    end

    def self.resource_id_name
      :test_two_eye_dee
    end
  end

  context '.resource_name' do
    it 'should return the underscored, demodulized class name by default' do
      TestResourceA.resource_name.should == 'test_resource_a'
    end

    it 'should be overridable' do
      TestResourceB.resource_name.should == 'test_two'
    end
  end

  context '.resource_id_name' do
    it 'should return a symbol of the resource name, prefixed by \'_id\'' do
      TestResourceA.resource_id_name.should == :test_resource_a_id
    end

    it 'should be overridable' do
      TestResourceB.resource_id_name.should == :test_two_eye_dee
    end
  end

  context '#resource_name' do
    it 'should delegate to the class-level method' do
      TestResourceA.new.resource_name.should == 'test_resource_a'
    end
  end

  context '#resource_id_name' do
    it 'should delegate to the class-level method' do
      TestResourceA.new.resource_id_name.should == :test_resource_a_id
    end
  end

  context '#resource_id' do
    it 'should delegate to the attribute corresponding to #resource_id_name' do
      resource = TestResourceA.new(:test_resource_a_id => 2)
      resource.resource_id.should == 2
    end
  end
end
