module Magento
  module Deletable
    extend ActiveSupport::Concern

    included do
      include Magento::Connectable
      include Magento::Resource
    end

    module InstanceMethods
      def delete
        call("#{resource_name}.delete", resource_id)
      end
    end
  end
end
