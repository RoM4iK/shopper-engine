module ShopperEngine
  class CreditCard < ActiveRecord::Base
      belongs_to :customer
      has_many :orders

      validates :number, presence: true, uniqueness: true, numericality: true, length: { is: 16 }
      validates :cvv, presence: true, numericality: true, length: { is: 3 }
      validates :expiration_month, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 12}
      validates :expiration_year, presence: true, numericality: { greater_than_or_equal_to: Date.current.year }
      validates :first_name, presence: true
      validates :last_name, presence: true
  end
end
