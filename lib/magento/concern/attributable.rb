module Magento
  module Attributable
    extend ActiveSupport::Concern

    included do
      attr_accessor :attributes
    end

    module InstanceMethods
      def initialize(attributes = {})
        super
      rescue ArgumentError
        super()
      ensure
        @attributes = attributes
      end

      def respond_to?(message, include_private = false)
        super || begin
          message.to_s =~ /(.*)=?$/
          attributes.include?($1.to_sym)
        end
      end

      private
        def method_missing(method, *arguments, &block)
          if method.to_s =~ /(.*)=$/
            if attributes.include?($1.to_sym)
              if arguments.size != 1
                raise ArgumentError, "wrong number of arguments (#{arguments.size} for 1)"
              else
                return attributes[$1.to_sym] = arguments.first
              end
            end
          elsif attributes.include?(method)
            if arguments.any?
              raise ArgumentError, "wrong number of arguments (#{arguments.length} for 0)"
            else
              return attributes[method]
            end
          end

          super
        end
    end
  end
end
