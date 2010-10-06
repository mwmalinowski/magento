require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Attributable do
  class TestAttributable
    include Magento::Attributable
  end

  before(:each) do
    @attributable = TestAttributable.new(:a => 1)
  end

  it 'should provide an attributes hash accessor, with initializer' do
    @attributable.attributes.should == {:a => 1}
  end

  it 'should respond to all attribute hash keys' do
    @attributable.should respond_to(:a)
  end

  it 'should have a getter method for each attribute hash key' do
    @attributable.a.should == 1
  end

  it 'should have a setter method for each attribute hash key' do
    @attributable.a = 2
    @attributable.attributes[:a].should == 2
  end

  it 'should not set respond to methods that are not a hash key' do
    lambda{@attributable.b = 5}.should raise_exception(NoMethodError)
  end

  it 'should enforce arity on the getter methods' do
    lambda{@attributable.a(1)}.should raise_exception(ArgumentError)
  end
end
