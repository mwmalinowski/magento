require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Connection::Client do
  context '.default' do
    before(:each) do
      Magento::Connection::Client.send(:class_variable_set, '@@default', nil)
    end

    it 'should return a Magento::Connection::Client::SOAP instance if wsdl_path is specified in the configuration' do
      configuration = mock(:configuration, :xmlrpc_path => '/xmlrpc', :wsdl_path => '/wsdl')
      Magento::Configuration.should_receive(:default).and_return(configuration)
      Magento::Connection::Client.default.should be_a(Magento::Connection::Client::SOAP)
    end

    it 'should return a Magento::Connection::Client::XMLRPC instance if xmlrpc_path is specified in the configuration and wsdl_path is not' do
      configuration = mock(:configuration, :xmlrpc_path => '/xmlrpc', :wsdl_path => nil)
      Magento::Configuration.should_receive(:default).and_return(configuration)
      Magento::Connection::Client.default.should be_a(Magento::Connection::Client::XMLRPC)
    end
  end
end
