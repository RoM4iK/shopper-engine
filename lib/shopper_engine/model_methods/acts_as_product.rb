module ShopperEngine
  module ActsAsProduct
   extend ActiveSupport::Concern
    module ClassMethods
      def acts_as_product
        send(:has_many, :order_items, {
          class_name: 'ShopperEngine::OrderItem',
          as: :product
        })
      end
    end
  end
end
