require 'optparse'
require 'irb'
require 'irb/completion'

module Magento
  module Console
    def self.start
      options = {}

      OptionParser.new do |opt|
        opt.banner = 'Usage: console [configuration_file_path] [options]'

        opt.on('-f', '--config-file [PATH]', String, 'Specify configuration file path') do |configuration_file_path|
          options[:configuration_file_path] = configuration_file_path
        end

        opt.on('-c', '--client [TYPE]', [:xmlrpc, :soap],
            'Specify client type. Possible values: xmlrpc, soap. Default value: xmlrpc') do |client_type|
          options[:client_type] = client_type
        end

        opt.parse!(ARGV)
      end

      configuration = Magento::Configuration.new(:file_path => (options[:configuration_file_path]))
      client = case (options[:client_type] || :xmlrpc)
                 when :xmlrpc  then Magento::Connection::Client::XMLRPC.new(configuration)
                 when :soap    then Magento::Connection::Client::SOAP.new(configuration)
               end

      Magento.connection = Magento::Connection.new(configuration, client)

      ARGV << '--simple-prompt'
      IRB.start
    end
  end
end
