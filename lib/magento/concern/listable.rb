module Magento
  module Listable
    extend ActiveSupport::Concern

    included do
      include Magento::Connectable
      include Magento::Resource
    end

    module ClassMethods
      def list(*arguments)
        call("#{resource_name}.list", *arguments).map do |attributes|
          self.new(attributes)
        end
      end
    end
  end
end
