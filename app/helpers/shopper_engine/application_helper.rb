module ShopperEngine
  module ApplicationHelper
    def current_cart
      Cart.current_cart
    end

    def cart_total
      current_cart.price
    end
  end
end
