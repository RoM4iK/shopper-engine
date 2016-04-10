module ShopperEngine
  module Checkout
    class Payment
      def initialize(cart:, params:, user:)
        @user = user
        @cart = cart
        @params = params
      end

      def show
        @card_editable = card_have_no_orders?(@cart.credit_card)
        @credit_card = @card_editable ? @cart.credit_card : @user.credit_cards.new
        @user_credit_cards = @user.credit_cards.all
      end

      def update
        unless credit_card_selected?
          @credit_card = @cart.credit_card || @user.credit_cards.new
          unless card_have_no_orders?(@credit_card)
            @credit_card = @user.credit_cards.new
          end
          @credit_card.attributes = credit_card_params
          @credit_card.save!
          @cart.credit_card = @credit_card
          @cart.save
        end
      end

      private

      def credit_card_params
        @params.require(:credit_card).permit(
          :number, :cvv, :expiration_month, :expiration_year, :first_name, :last_name
        )
      end

      def card_have_no_orders?(card = nil)
        return false if card === nil
        return card.orders.placed.count == 0
      end

      def credit_card_selected?
        cart_params = @params.permit(cart: [:credit_card_id])
        if cart_params[:cart] && cart_params[:cart][:credit_card_id]
          @cart.update cart_params[:cart]
        end
      end
    end
  end
end
