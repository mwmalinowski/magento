module Magento
  module Savable
    extend ActiveSupport::Concern

    included do
      include Magento::Resource
      include Magento::Connectable
      include Magento::Attributable
    end

    module InstanceMethods
      def save
        if resource_id
          call("#{resource_name}.update", resource_id, attributes_without_id)
        else
          resource_id = call("#{resource_name}.create", attributes_without_id)
          attributes[resource_id_name] = resource_id
        end

        self
      end

      private
        def attributes_without_id
          new_attributes = attributes.dup
          new_attributes.delete(resource_id_name)
          new_attributes
        end
    end
  end
end
