require File.dirname(__FILE__) + '/../spec_helper'
require 'fakefs/safe'
require 'fakefs/spec_helpers'

describe Magento::Configuration do
  include FakeFS::SpecHelpers

  it 'should provide methods for each option' do
    configuration = Magento::Configuration.new(
      :username =>  'arnold.rothstein',
      :api_key =>   'abc123',
      :host =>      'magento.com',
      :path =>      '/api',
      :port =>      '1080'
    )
    configuration.username.should == 'arnold.rothstein'
    configuration.api_key.should ==  'abc123'
    configuration.host.should ==     'magento.com'
    configuration.path.should ==     '/api'
    configuration.port.should ==     '1080'
  end

  it 'should load values from a specified file' do
    yaml = {:username =>  'charles.luciano',
            :api_key =>   'def456',
            :host =>      'magento.com',
            :path =>      '/the_api',
            :port =>      '8080'}.to_yaml
    File.open('~/magento.yml', 'w'){|f| f.write yaml}

    configuration = Magento::Configuration.new(:file_path => '~/magento.yml')
    configuration.username.should == 'charles.luciano'
    configuration.api_key.should ==  'def456'
    configuration.host.should ==     'magento.com'
    configuration.path.should ==     '/the_api'
    configuration.port.should ==     '8080'
  end

  it 'should default path to \'/api/xmlrpc\' and port to \'80\'' do
    configuration = Magento::Configuration.new(
      :username =>  'salvatore.maranzano',
      :api_key =>   'xyz789',
      :host =>      'magento.com'
    )
    configuration.path.should ==     '/api/xmlrpc'
    configuration.port.should ==     '80'
  end
end
