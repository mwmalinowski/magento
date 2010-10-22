module Magento
  module Reloadable
    extend ActiveSupport::Concern

    included do
      include Magento::Attributable
      include Magento::Connectable
      include Magento::Resource
    end

    ADDITIONAL_ARGUMENT_KEYS = [:file, :store_view]

    module InstanceMethods
      def reload(options = {})
        additional_arguments = options.values_at(*ADDITIONAL_ARGUMENT_KEYS).compact
        self.attributes = call("#{resource_name}.info", resource_id, *additional_arguments)
        self
      end
    end
  end
end
