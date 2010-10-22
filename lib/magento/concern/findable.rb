module Magento
  module Findable
    extend ActiveSupport::Concern

    included do
      include Magento::Reloadable
    end

    module ClassMethods
      def find(resource_id, options = {})
        self.new(resource_id_name => resource_id).reload(options)
      end
    end
  end
end
