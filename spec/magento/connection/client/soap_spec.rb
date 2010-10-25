require File.dirname(__FILE__) + '/../../../spec_helper'

describe Magento::Connection::Client::XMLRPC do
  before(:each) do
    @soap_client = mock(:soap_client)
    @client = Magento::Connection::Client::SOAP.new(mock(:configuration))
    @client.should_receive(:raw).and_return(@soap_client)
  end

  context '#login' do
    it 'should supply username and api_key to #login' do
      soap_object = mock(:soap_object)
      soap_object.should_receive(:body=).with(:api_user => 'john', :api_key => 'abc123')
      response = mock(:response, :to_hash => {:login_response => {:login_return => 'def456'}})
      @soap_client.should_receive(:login).and_yield(soap_object).and_return(response)
      @client.login('john', 'abc123').should == 'def456'
    end
  end

  context '#call' do
    it 'should supply session_id, method and the aruments to #call' do
      soap_object = mock(:soap_object)
      soap_object.should_receive(:body=).with(:session_id => 'def456', :resource_path => 'resource.method', :arguments => ['arg1', 'arg2'])
      response = mock(:response, :to_hash => {:call_response => {:call_return => 'result'}})
      @soap_client.should_receive(:call).and_yield(soap_object).and_return(response)
      @client.call('def456', 'resource.method', 'arg1', 'arg2').should == 'result'
    end
  end
end
