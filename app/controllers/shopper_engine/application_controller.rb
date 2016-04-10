module ShopperEngine
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_cart

    def get_cart
      @cart
    end

    def set_cart
      initialize_cart if session[:cart_id].blank?
      begin
        @cart = ShopperEngine::Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        initialize_cart
      end
    end

    def initialize_cart
      @cart = ShopperEngine::Cart.create
      session[:cart_id] = @cart.id
    end

    def current_user
      send("current_#{ShopperEngine::CONFIG[:devise_scope]}")
    end
  end
end
