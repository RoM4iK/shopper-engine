module ShopperEngine
  class OrderItem < ActiveRecord::Base
      belongs_to :product, polymorphic: true
      belongs_to :order, class_name: 'ShopperEngine::Order'

      def update_quantity (value)
        self.price = product.price * value
        self.quantity = value
      end

      validates :price, presence: true
      validates :quantity, presence: true
  end
end
