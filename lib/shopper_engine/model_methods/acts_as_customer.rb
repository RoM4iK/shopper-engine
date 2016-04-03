module ShopperEngine
  module ActsAsCustomer
   extend ActiveSupport::Concern
    module ClassMethods
      def acts_as_customer(options = {})
        send(:has_many, :orders, {
          class_name: 'ShopperEngine::Order'
        })
      end
    end
  end
end
