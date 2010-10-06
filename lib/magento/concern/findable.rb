module Magento
  module Findable
    extend ActiveSupport::Concern

    included do
      include Magento::Reloadable
    end

    module ClassMethods
      def find(resource_id)
        self.new(resource_id_name => resource_id).reload
      end
    end
  end
end
