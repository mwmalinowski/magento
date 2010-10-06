module Magento
  module Creatable
    extend ActiveSupport::Concern

    included do
      include Magento::Savable
    end

    module ClassMethods
      def create(attributes = {})
        self.new(attributes).save
      end
    end
  end
end
