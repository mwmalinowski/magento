module Magento
  module Reloadable
    extend ActiveSupport::Concern

    included do
      include Magento::Attributable
      include Magento::Connectable
      include Magento::Resource
    end

    module InstanceMethods
      def reload
        self.attributes = call("#{resource_name}.info", resource_id)
        self
      end
    end
  end
end
