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
          call("#{resource_name}.update", resource_id, *update_arguments)
        else
          resource_id = call("#{resource_name}.create", *create_arguments)
          attributes[resource_id_name] = resource_id
        end

        self
      end

      private
        def create_arguments
          [attributes]
        end

        def update_arguments
          [attributes_without_id]
        end

        def attributes_without_id
          new_attributes = attributes.dup
          new_attributes.delete(resource_id_name)
          new_attributes
        end
    end
  end
end
