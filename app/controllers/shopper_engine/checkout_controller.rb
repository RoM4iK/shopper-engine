module ShopperEngine
  class CheckoutController < ApplicationController
    include Wicked::Wizard
    include CartHelper
    layout "layouts/application"

    before_action :authenticate_customer!
    before_action :get_current_cart

    around_action :hande_errors

    steps :billing, :shipping, :delivery, :payment, :confirmation

    def initialize_steps
      @checkout_steps = {
        :billing => Checkout::Addresses.new(:cart => @cart, :user => current_user, :type => :billing, :params => params),
        :shipping => Checkout::Addresses.new(:cart => @cart, :user => current_user, :type => :shipping, :params => params),
        :delivery => Checkout::Delivery.new(:cart => @cart, :params => params),
        :payment => Checkout::Payment.new(:cart => @cart, :user => current_user, :params => params),
        :confirmation => Checkout::Confirmation.new(:cart => @cart)
      }
    end

    def show
      return redirect_to cart_path if @cart.order_items.empty?
      initialize_steps
      @checkout_steps[step].show
      render_wizard
    end

    def update
      initialize_steps
      @checkout_steps[step].update
      redirect_to next_wizard_path
    end

    private

    def render_wizard
      set_instance_variables!
      super
    end

    def get_current_cart
      @cart = current_cart
    end

    def confirmation
      if @cart.billing_address.blank?
        return redirect_with_message :billing, "You must fill the billing address"
      end
      if @cart.shipping_address.blank?
        return redirect_with_message :shipping, "You must fill the shipping address"
      end
      if @cart.delivery.blank?
        return redirect_with_message :delivery, "You must select the delivery method"
      end
      if @cart.credit_card.blank?
        return redirect_with_message :payment, "You must fill the credit card info"
      end
      render_wizard
    end

    def redirect_with_message(step, message)
      flash[:alert] = message
      redirect_to wizard_path(step)
    end

    def hande_errors
      begin
        yield
        rescue ActiveRecord::RecordInvalid => e
          flash.now[:alert] = e.record.errors.full_messages
          render_wizard
        rescue ActionController::ParameterMissing
          flash.now[:alert] = "You must select delivery method"
      end
    end

    def set_instance_variables!
      @checkout_steps[step].instance_values.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end
end
