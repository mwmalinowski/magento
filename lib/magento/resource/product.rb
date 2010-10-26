module Magento
  class Product
    include Magento::StoreViewable
    include Magento::Listable
    include Magento::Infoable
    include Magento::Creatable
    include Magento::Updatable
    include Magento::Deletable

    class << self
      def list(criteria = {})
        store_view = criteria.delete(:store_view)
        super criteria, store_view
      end
    end

    private
      def create_arguments
        attributes_subset = attributes.dup
        type = attributes_subset.delete(:type)
        attribute_set_id = attributes_subset.delete(:attribute_set_id)
        sku = attributes_subset.delete(:sku)
        [type, attribute_set_id, sku, attributes_subset]
      end

      def update_arguments
        attributes_subset = attributes_without_id
        store_view = attributes_subset.delete(:store_view)
        [attributes_subset, store_view]
      end
  end
end
