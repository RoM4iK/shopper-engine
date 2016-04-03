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
      
      scope :placed, -> { where("state != #{self::PAYMENT}") }
      scope :payment, -> { where("state = #{self::PAYMENT}") }
      scope :shipping, -> { where("state = #{self::SHIPPING}") }
      scope :finished, -> { where("state = #{self::FINISHED}") }
  end
end
