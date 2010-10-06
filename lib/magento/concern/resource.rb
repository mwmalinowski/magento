require 'active_support/inflector'

module Magento
  module Resource
    extend ActiveSupport::Concern

    included do
      include Magento::Attributable
    end

    module ClassMethods
      def resource_name
        class_name = ActiveSupport::Inflector.demodulize self.name
        ActiveSupport::Inflector.underscore class_name
      end

      def resource_id_name
        "#{resource_name}_id".to_sym
      end
    end

    module InstanceMethods
      def resource_name
        self.class.resource_name
      end

      def resource_id_name
        self.class.resource_id_name
      end

      def resource_id
        attributes[self.class.resource_id_name]
      end
    end
  end
end