module ShopperEngine
  module Checkout
    class Confirmation
      def initialize(cart:)
        @cart = cart
      end

      def show
        error_with_message :payment, "You must fill the credit card info" if @cart.credit_card.blank?
        error_with_message :delivery, "You must select the delivery method" if @cart.delivery.blank?
        error_with_message :shipping, "You must fill the shipping address" if @cart.shipping_address.blank?
        error_with_message :billing, "You must fill the billing address" if @cart.billing_address.blank?
      end

      private

      def error_with_message(step, message)
        @error = {
          step: step,
          message: message
        }
      end
    end
  end
end
