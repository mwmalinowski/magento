module Magento
  class Category
    include Magento::Connectable
    include Magento::Resource
    include Magento::Deletable
    include Magento::Infoable
    include Magento::StoreViewable

    class << self
      def tree(options = {})
        call("#{resource_name}.tree", options[:parent_id], options[:store_view])
      end

      def level(options = {})
        call("#{resource_name}.level", options[:website], options[:store_view], options[:parent_id])
      end

      def create(attributes)
        parent_id = attributes.delete(:parent_id)
        store_view = attributes.delete(:store_view)
        resource_id = call("#{resource_name}.create", parent_id, attributes, store_view)
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

    def move(options = {})
      call("#{resource_name}.move", resource_id, options[:parent_id], options[:after_id])
    end
  end
end
