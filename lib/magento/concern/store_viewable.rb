module Magento
  module StoreViewable
    extend ActiveSupport::Concern

    included do
      include Magento::Resource
      include Magento::Connectable
    end

    module ClassMethods
      def current_store
        call("#{resource_name}.currentStore")
      end

      def current_store=(store_view)
        call("#{resource_name}.currentStore", store_view)
      end
    end
  end
end
