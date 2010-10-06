module Magento
  module Infoable
    extend ActiveSupport::Concern

    included do
      include Magento::Findable
      include Magento::Attributable
    end

    module ClassMethods
      def info(resource_id)
        find(resource_id).attributes
      end
    end
  end
end
