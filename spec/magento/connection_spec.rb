require File.dirname(__FILE__) + '/../spec_helper'

describe Magento::Connection do
  context '.scrub_method' do
    it 'should return a string' do
      Magento::Connection.scrub_method(:call).should == 'call'
    end
  end

  context '.scrub_arguments' do
    it 'should return an array of strings' do
      Magento::Connection.scrub_arguments([:abc, 1]).should == ['abc', '1']
    end

    it 'should stringify any included hashes' do
      Magento::Connection.scrub_arguments([:abc, {:a => 2}]).should == ['abc', {'a' => '2'}]
    end

    it 'should not stringify arrays within a hash, but it should strinfigy the array entries' do
      Magento::Connection.scrub_arguments([:abc, {:a => [2, 3]}]).should == ['abc', {'a' => ['2', '3']}]
    end
  end

  context '.scrub_response' do
    it 'should symbolize any hash keys' do
      Magento::Connection.scrub_response([{'abc' => 'def'}]).should == [{:abc => 'def'}]
    end
  end

  before(:each) do
    @configuration = Magento::Configuration.new(
      :username =>    'arnold.rothstein',
      :api_key =>     'abc123',
      :host =>        'magento.com',
      :xmlrpc_path => '/api',
      :port =>        '1080'
    )

    @client     = mock(:client)
    @connection = Magento::Connection.new(@configuration, @client)
  end

  context '#call' do
    it 'should delegate to call on the client and return the result' do
      @client.should_receive(:login).with('arnold.rothstein', 'abc123').and_return('def456')
      @client.should_receive(:call).with('def456', 'sample', 'a', '1').and_return('result')
      @connection.login
      @connection.call('sample', 'a', '1').should == 'result'
    end
  end

  context '#login' do
    it 'should return the session ID returned from calling \'login\'' do
      @client.should_receive(:login).with('arnold.rothstein', 'abc123').and_return('def456')
      @connection.login.should == 'def456'
    end
  end

  context '#logged_in?' do
    it 'should return false if the connection was never logged in' do
      @connection.logged_in?.should be_false
    end

    it 'should return true if the connection was logged in' do
      @client.should_receive(:login).with('arnold.rothstein', 'abc123').and_return('def456')
      @connection.login
      @connection.logged_in?.should be_true
    end
  end
end
