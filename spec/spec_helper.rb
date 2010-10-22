require File.dirname(__FILE__) + '/../lib/magento'

module Magento
  module Test
    SESSION_ID = 'abc123' unless defined?(Magento::Test::SESSION_ID)

    def self.stub_service(options = {})
      unless Magento.connection.session_id
        Magento.connection.instance_variable_set(:@session_id, SESSION_ID)
      end

      client = Magento.connection.send(:client)
      client.should_receive(:call).with(SESSION_ID, options[:method], *options[:arguments]).
        and_return(options[:response])
    end
  end
end
