module Magento
  class Connection
    module Client
      extend ActiveSupport::Concern

      @@default = nil

      class << self
        def default
          @@default ||= begin
            configuration = Magento::Configuration.default
            if configuration.xmlrpc_path and !configuration.wsdl_path
              Magento::Connection::Client::XMLRPC.new(configuration)
            else
              Magento::Connection::Client::SOAP.new(configuration)
            end
          end
        end
      end

      module InstanceMethods
        def initialize(configuration)
          @configuration = configuration
        end

        def login(username, api_key)
        end

        def call(session_id, method, *arguments)
        end
      end
    end
  end
end

