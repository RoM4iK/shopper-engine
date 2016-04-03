class CheckoutController < ApplicationController
  include Wicked::Wizard
  include Checkout::Addresses
  include Checkout::Delivery
  include Checkout::Payment

  before_action :authenticate_customer!
  before_action :get_current_order

  around_action :handle_validation_errors

  steps :billing, :shipping, :delivery, :payment, :confirmation

  def show
    return redirect_to cart_path if @order.order_items.empty?
    case step
      when :billing
        billing
      when :shipping
        shipping
      when :payment
        payment
      when :confirmation
        #confirmation can redirect to other step, or render wizard
        return confirmation
    end
    render_wizard
  end

  def update
    case step
      when :billing
        update_billing
      when :shipping
        update_shipping
      when :delivery
        update_delivery
      when :payment
        update_payment
    end
  end

  private

  def get_current_order
    @order = current_customer.current_order
  end

  def confirmation
    if @order.billing_address.blank?
      return redirect_with_message :billing, "You must fill the billing address"
    end
    if @order.shipping_address.blank?
      return redirect_with_message :shipping, "You must fill the shipping address"
    end
    if @order.delivery.blank?
      return redirect_with_message :delivery, "You must select the delivery method"
    end
    if @order.credit_card.blank?
      return redirect_with_message :payment, "You must fill the credit card info"
    end
    render_wizard
  end

  def redirect_with_message(step, message)
    flash[:alert] = message
    redirect_to wizard_path(step)
  end

  def handle_validation_errors
    begin
      yield
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:alert] = e.record.errors.full_messages
      render_wizard
    end
  end
end
