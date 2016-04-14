module ShopperEngine
  module CartHelper
    def add_to_cart_button(product)
      @product = product
      render partial: 'shopper_engine/cart/add_to_cart_button'
    end
    def current_cart
      if session[:cart_id]
        ShopperEngine::Cart.find(session[:cart_id])
      else
        create_cart
      end
    end

    def cart_total
      current_cart.price
    end
    private
    def create_cart
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end
end
