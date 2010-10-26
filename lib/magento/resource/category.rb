module Magento
  class Category
    include Magento::Connectable
    include Magento::StoreViewable
    include Magento::Infoable
    include Magento::Creatable
    include Magento::Updatable
    include Magento::Deletable

    class << self
      def tree(options = {})
        call("#{resource_name}.tree", options[:parent_id], options[:store_view])
      end

      def level(options = {})
        call("#{resource_name}.level", options[:website], options[:store_view], options[:parent_id])
      end
    end

    def move(options = {})
      call("#{resource_name}.move", resource_id, options[:parent_id], options[:after_id])
    end

    private
      def create_arguments
        attributes_subset = attributes.dup
        parent_id = attributes_subset.delete(:parent_id)
        store_view = attributes_subset.delete(:store_view)
        [parent_id, attributes_subset, store_view]
      end

      def update_arguments
        attributes_subset = attributes_without_id
        store_view = attributes_subset.delete(:store_view)
        [attributes_subset, store_view]
      end
  end
end
