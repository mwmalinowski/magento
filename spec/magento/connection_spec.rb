require File.dirname(__FILE__) + '/../spec_helper'

describe Magento::Connection do
  before(:each) do
    @configuration = Magento::Configuration.new(
      :username =>  'arnold.rothstein',
      :api_key =>   'abc123',
      :host =>      'magento.com',
      :path =>      '/api',
      :port =>      '1080'
    )

    @connection = Magento::Connection.new(@configuration)
  end

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
  end

  context '.scrub_response' do
    it 'should symbolize any hash keys' do
      Magento::Connection.scrub_response([{'abc' => 'def'}]).should == [{:abc => 'def'}]
    end
  end

  context '#call' do
    it 'should delegate to call on the client and return the result' do
      mock_client = mock(:client)
      mock_client.should_receive(:call).with('login', 'arnold.rothstein', 'abc123').and_return('def456')
      mock_client.should_receive(:call).with('call', 'def456', 'sample', 'a', '1').and_return('result')
      @connection.should_receive(:client).twice.and_return(mock_client)
      @connection.log_in
      @connection.call('sample', 'a', '1').should == 'result'
    end
  end

  context '#log_in' do
    it 'should return the session ID returned from calling \'login\'' do
      mock_client = mock(:client)
      mock_client.should_receive(:call).with('login', 'arnold.rothstein', 'abc123').and_return('def456')
      @connection.should_receive(:client).and_return(mock_client)
      @connection.log_in.should == 'def456'
    end
  end

  context '#logged_in?' do
    it 'should return false if the connection was never logged in' do
      @connection.logged_in?.should be_false
    end

    it 'should return true if the connection was logged in' do
      mock_client = mock(:client, :call => 'abc123')
      @connection.should_receive(:client).and_return(mock_client)
      @connection.log_in
      @connection.logged_in?.should be_true
    end
  end
end
