require File.dirname(__FILE__) + '/../../../spec_helper'

describe Magento::Connection::Client::XMLRPC do
  before(:each) do
    @soap_client = mock(:soap_client)
    @client = Magento::Connection::Client::Soap.new(mock(:configuration))
    @client.should_receive(:raw).and_return(@soap_client)
  end

  context '#login' do
    it 'should supply username and api_key to #login' do
      @soap_client.should_receive(:login).with('john', 'abc123')
      @client.login('john', 'abc123')
    end
  end

  context '#call' do
    it 'should supply session_id, method and the aruments to #call' do
      @soap_client.should_receive(:call).with('def456', 'method', 'arg1', 'arg2')
      @client.call('def456', 'method', 'arg1', 'arg2')
    end
  end
end
