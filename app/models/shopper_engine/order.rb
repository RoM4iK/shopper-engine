module ShopperEngine
  class Order < ActiveRecord::Base
      SHIPPING = 0
      FINISHED = 1

      belongs_to :customer
      belongs_to :credit_card, class_name: 'ShopperEngine::CreditCard'
      belongs_to :delivery, class_name: 'ShopperEngine::Delivery'

      has_many :order_items

      belongs_to :billing_address, class_name: ShopperEngine::Address
      belongs_to :shipping_address, class_name: ShopperEngine::Address

      scope :placed, -> { where("state != NULL") }
      scope :shipping, -> { where("state = #{self::SHIPPING}") }
      scope :finished, -> { where("state = #{self::FINISHED}") }
  end
end
