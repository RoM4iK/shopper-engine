require_dependency "shopper_engine/application_controller"

module ShopperEngine
  class CartController < ApplicationController
    layout 'layouts/application'
    before_action :get_current_cart

    def index
    end

    def add
      @cart.add_item(find_product, cart_params[:quantity])
      flash.notice = 'Book added to your cart'
      redirect_to(action: :index)
    end

    def update_quantity
      order_item = @cart.order_items.find(cart_params[:id])
      @cart.update_quantity(order_item, params[:quantity])
      redirect_to(action: :index)
    end

    def place
      @cart.place!
      flash[:notice] = "Your order has placed"
      redirect_to(controller: :shopper_engine_orders, action: :list)
    end

    private
    def cart_params
      params.permit([:id, :product_type, :product_id, :quantity])
    end

    def get_current_cart
      @cart = get_cart
    end

    def find_product
      class_name = ShopperEngine::PRODUCT_CLASSES.detect { |c| c == cart_params[:product_type] }
      class_name.camelize.constantize.find(cart_params[:product_id])
    end
  end
end
