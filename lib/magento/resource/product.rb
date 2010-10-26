module Magento
  class Product
    include Magento::Connectable
    include Magento::Resource
    include Magento::StoreViewable
    include Magento::Listable
    include Magento::Infoable
    include Magento::Deletable

    class << self
      def list(criteria = {})
        store_view = criteria.delete(:store_view)
        super criteria, store_view
      end

      def create(attributes)
        type = attributes.delete(:type)
        attribute_set_id = attributes.delete(:attribute_set_id)
        sku = attributes.delete(:sku)
        resource_id = call("#{resource_name}.create", type, attribute_set_id, sku, attributes)
        new(attributes.merge(resource_id_name => resource_id))
      end
    end

    def update(new_attributes = {})
      store_view = new_attributes.delete(:store_view)
      attributes_without_id = self.attributes.dup
      attributes_without_id.delete(resource_id_name)
      call("#{resource_name}.update", resource_id, attributes_without_id.merge(new_attributes), store_view)
      self.attributes = self.attributes.merge(new_attributes)
    end
  end
end
