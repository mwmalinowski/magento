require 'savon'

module Magento
  class Connection
    module Client
      class Soap
        include Magento::Connection::Client

        def login(username, api_key)
          raw.login(username, api_key)
        end

        def call(session_id, method, *arguments)
          raw.call(session_id, method, *arguments)
        end

        private
          def raw
            @raw ||= Savon::Client.new(@configuration.host + @configuration.wsdl_path)
          end
      end
    end
  end
end
