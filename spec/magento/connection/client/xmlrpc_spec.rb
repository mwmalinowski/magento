require File.dirname(__FILE__) + '/../../../spec_helper'

describe Magento::Connection::Client::XMLRPC do
  before(:each) do
    @xmlrpc_client = mock(:xmlrpc_client)
    @client = Magento::Connection::Client::XMLRPC.new(mock(:configuration))
    @client.should_receive(:raw).and_return(@xmlrpc_client)
  end

  context '#login' do
    it 'should supply \'login\', username and api_key to #call' do
      @xmlrpc_client.should_receive(:call).with('login', 'john', 'abc123')
      @client.login('john', 'abc123')
    end
  end

  context '#call' do
    it 'should supply \'call\', session_id, method and the aruments to #call' do
      @xmlrpc_client.should_receive(:call).with('call', 'def456', 'method', 'arg1', 'arg2')
      @client.call('def456', 'method', 'arg1', 'arg2')
    end
  end
end
