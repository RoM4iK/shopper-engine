module ShopperEngine
  module Checkout
    class Delivery
      def initialize(cart:, params:)
        @cart = cart
        @params = params
      end

      def show
      end

      def update
        @cart.update @params.require(:cart).permit(:delivery_id)
      end
    end
  end
end
