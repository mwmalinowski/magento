require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Connectable do
  class TestConnectable
    include Magento::Connectable
  end

  context '.connection' do
    it 'should return a Magento::Connection instance' do
      TestConnectable.connection.should be_a(Magento::Connection)
    end
  end

  context '.call' do
    it 'should delegate to .connection' do
      TestConnectable.connection.should_receive(:call).with('method', 'arg1', 'arg2')
      TestConnectable.call('method', 'arg1', 'arg2')
    end
  end

  context '#connection' do
    it 'should return a Magento::Connection instance by default' do
      TestConnectable.new.connection.should be_a(Magento::Connection)
    end

    it 'should support dependency injection at initialization' do
      connection = mock('connection')
      connectable = TestConnectable.new(:connection => connection)
      connectable.connection.should == connection
    end
  end

  context '#call' do
    it 'should delegate to #connection' do
      connectable = TestConnectable.new
      connectable.should_receive(:call).with('method', 'arg1', 'arg2')
      connectable.call('method', 'arg1', 'arg2')
    end
  end
end
