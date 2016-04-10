module Checkout::Addresses
  def billing
    get_customer_addresses
    @billing_address = @order.billing_address || current_customer.addresses.new
    get_address_editability(@billing_address)
  end

  def update_billing
    unless address_selected?
      @billing_address = @order.billing_address || current_customer.addresses.new
      unless address_have_no_orders?
        @billing_address = current_customer.addresses.new
      end
      @billing_address.attributes = params.require(:address).permit(:address, :zipcode, :city, :phone, :country_id)
      @billing_address.save!
      @order.billing_address = @billing_address
      @order.save
    end
    redirect_to next_wizard_path
  end

  def shipping
    get_customer_addresses
    @shipping_address = @order.shipping_address || current_customer.addresses.new
    @shipping_address = current_customer.addresses.new if @shipping_address == @order.billing_address
    get_address_editability(@shipping_address)
  end

  def update_shipping
    unless address_selected?
      @shipping_address = @order.shipping_address || current_customer.addresses.new
      @shipping_address = current_customer.addresses.new if @shipping_address == @order.billing_address
      unless address_have_no_orders?
        @shipping_address = current_customer.addresses.new
      end
      if params.permit(:skip_shipping)[:skip_shipping] == "true"
        skip_shipping
      else
        @shipping_address.attributes = params.require(:address).permit(
          :address, :zipcode, :city, :phone, :country_id
        )
        @shipping_address.save!
        @order.shipping_address = @shipping_address
        @order.save
      end
    end
    redirect_to next_wizard_path
  end

  def skip_shipping
    @order.update shipping_address: @order.billing_address
    @order.save
  end

  private

  def address_have_no_orders?(address = nil)
    return false if address === nil
    return false unless address.id
    return address.orders.placed.count == 0
  end

  def address_selected?
    order_params = params.permit(order: [:shipping_address, :billing_address])
    if order_params[:order]
      @order.update find_selected_address! order_params[:order]
    end
  end

  def find_selected_address!(order)
    order[:shipping_address] = current_customer.addresses.find order[:shipping_address] if order[:shipping_address]
    order[:billing_address] = current_customer.addresses.find order[:billing_address] if order[:billing_address]
    order
  end

  def get_customer_addresses
    @customer_addresses = current_customer.addresses.all
  end

  def get_address_editability(address)
    @address_editable = address_have_no_orders?(address)
  end

end
