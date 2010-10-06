module Magento
  class Customer
    include Magento::Listable
    include Magento::Creatable
    include Magento::Infoable
    include Magento::Updatable
    include Magento::Deletable
  end
end
