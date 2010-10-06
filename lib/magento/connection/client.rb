require 'xmlrpc/client'
require 'savon'

module Magento
  class Connection
    module Client
      extend ActiveSupport::Concern

      @@default = nil

      class << self
        def default
          @@default ||= Magento::Connection::Client::XMLRPC.new(Magento::Configuration.default)
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

