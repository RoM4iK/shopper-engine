module ShopperEngine
  class Order < ActiveRecord::Base
      PAYMENT = 0
      SHIPPING = 1
      FINISHED = 2

      belongs_to :customer
      belongs_to :credit_card, class_name: 'ShopperEngine::CreditCard'
      belongs_to :delivery, class_name: 'ShopperEngine::Delivery'

      has_many :order_items

      belongs_to :billing_address, class_name: ShopperEngine::Address
      belongs_to :shipping_address, class_name: ShopperEngine::Address

      validates :state, presence: true

      def add_item(product, quantity = 1)
          order_item = order_items.find_by({product: product})
          if (order_item)
             order_item.update_quantity(order_item.quantity + quantity)
             order_item.save
          else
              order_items.create({product: product, quantity: quantity, price: product.price * quantity})
          end
          update_price!
      end

      def update_quantity(order_item, quantity)
        if (quantity <= 0)
          order_item.delete
        else
          order_item.update_quantity(quantity)
          order_item.save
        end
        update_price!
      end


      def update_price!
          self.price = order_items.sum("price")
          save
      end

      scope :placed, -> { where("state != #{self::PAYMENT}") }
      scope :payment, -> { where("state = #{self::PAYMENT}") }
      scope :shipping, -> { where("state = #{self::SHIPPING}") }
      scope :finished, -> { where("state = #{self::FINISHED}") }
  end
end
