module ShopperEngine
  module Checkout
    class Addresses
      def initialize(cart:, type:, user:, params:)
        @user = user
        @cart = cart
        @type = type
        @params = params
      end

      def show
        get_user_addresses
        case @type
          when :billing
            @address = @cart.billing_address || @user.addresses.new
          when :shipping
            @address = @cart.shipping_address || @user.addresses.new
            @address = @user.addresses.new if @address == @cart.billing_address
        end
        get_address_editability
      end

      def update
        return skip_shipping if @params.permit(:skip_shipping)[:skip_shipping] == "true"
        unless address_selected?
          @address = @cart.send(address_type) || @user.addresses.new
          unless address_have_no_orders?
            @address = @user.addresses.new
          end
          @address.attributes = address_params
          @address.save!
          @cart.send("#{address_type}=", @address)
          @cart.save
        end
      end

      private

      def skip_shipping
        @cart.update shipping_address: @cart.billing_address
        @cart.save
      end

      def get_user_addresses
        @user_addresses = @user.addresses.all
      end

      def get_address_editability
        @address_editable = address_have_no_orders?(@address)
      end

      def address_have_no_orders?(address = nil)
        return false if address === nil
        return false unless address.id
        return address.orders.placed.count == 0
      end

      def address_selected?
        cart = @params.permit(cart: [address_type])
        if cart[:cart]
          @address = @user.addresses.find(cart[:cart][address_type])
          @cart.send("#{address_type}=", @address)
          @cart.save
        end
      end

      def address_params
        @params.require(:address).permit(:address, :zipcode, :city, :phone, :country_id)
      end

      def address_type
        "#{@type}_address"
      end

    end
  end
end
