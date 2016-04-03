module ShopperEngine
  class Delivery < ActiveRecord::Base
      validates :name, presence: true

      def short_description
        "#{name} (#{price}$)"
      end
  end
end
