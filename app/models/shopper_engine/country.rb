module ShopperEngine
  class Country < ActiveRecord::Base
      validates :name, presence: true, uniqueness: true
  end
end
