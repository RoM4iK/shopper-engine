module ShopperEngine
  module CartHelper
    def add_to_cart_button(product)
      @product = product
      render partial: 'cart/add_to_cart_button'
    end
  end
end
