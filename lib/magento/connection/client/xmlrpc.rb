require 'xmlrpc/client'

module Magento
  class Connection
    module Client
      class XMLRPC
        include Magento::Connection::Client

        def login(username, api_key)
          raw.call('login', username, api_key)
        end

        def call(session_id, method, *arguments)
          raw.call('call', session_id, method, *arguments)
        end

        private
          def raw
            @raw ||= XMLRPC::Client.new(@configuration.host, @configuration.xmlrpc_path, @configuration.port)
          end
      end
    end
  end
end
