module Magento
  module Updatable
    extend ActiveSupport::Concern

    included do
      include Magento::Savable
      include Magento::Attributable
    end

    module InstanceMethods
      def update(new_attributes = {})
        self.attributes = new_attributes.merge(attributes)
        save
      end
    end
  end
end
