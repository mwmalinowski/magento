module Magento
  module Connectable
    extend ActiveSupport::Concern

    module ClassMethods
      def connection
        Magento.connection
      end

      def call(method, *arguments)
        connection.call(method, *arguments)
      end
    end

    module InstanceMethods
      def initialize(options = {})
        super
      rescue ArgumentError
        super()
      ensure
        @connection = options.delete(:connection)
      end

      def connection
        @connection ||= self.class.connection
      end

      def call(method, *arguments)
        connection.call(method, *arguments)
      end
    end
  end
end
