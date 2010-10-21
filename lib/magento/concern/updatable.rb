module Magento
  module Updatable
    extend ActiveSupport::Concern

    included do
      include Magento::Savable
      include Magento::Attributable
    end

    module InstanceMethods
      def update(new_attributes = {})
        self.attributes = attributes.merge(new_attributes)
        save
      end
    end
  end
end
