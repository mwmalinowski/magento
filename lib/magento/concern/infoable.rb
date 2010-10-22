module Magento
  module Infoable
    extend ActiveSupport::Concern

    included do
      include Magento::Findable
      include Magento::Attributable
    end

    module ClassMethods
      def info(resource_id, options = {})
        find(resource_id, options).attributes
      end
    end
  end
end
