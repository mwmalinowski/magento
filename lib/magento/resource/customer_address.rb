module Magento
  class CustomerAddress
    include Magento::Listable
    include Magento::Creatable
    include Magento::Updatable
    include Magento::Infoable
    include Magento::Deletable

    class << self
      def list(customer_id)
        super(customer_id)
      end

      def create(customer_id, attributes)
        super(attributes.merge(:customer_id => customer_id))
      end
    end

    private
      def create_arguments
        [customer_id, attributes_without_customer_id]
      end

      def attributes_without_customer_id
        new_attributes = attributes.dup
        new_attributes.delete(:customer_id)
        new_attributes
      end
  end
end
