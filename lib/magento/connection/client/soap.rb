require 'savon'

module Magento
  class Connection
    module Client
      class SOAP
        include Magento::Connection::Client

        def login(api_user, api_key)
          response = raw.login do |soap|
            soap.body = {:api_user => api_user, :api_key => api_key}
          end

          response.to_hash[:login_response][:login_return]
        end

        def call(session_id, resource_path, *arguments)
          response = raw.call 'call' do |soap|
            soap.body = {:session_id => session_id, :resource_path => resource_path,
              :arguments => arguments}
          end

          response.to_hash[:call_response][:call_return]
        end

        private
          def raw
            @raw ||= Savon::Client.new(@configuration.host + @configuration.wsdl_path)
          end
      end
    end
  end
end
