module Checkout::Payment
  def payment
    @card_editable = card_have_no_orders?(@order.credit_card)
    @credit_card = @card_editable ? @order.credit_card : current_customer.credit_cards.new 
    @customer_credit_cards = current_customer.credit_cards.all
  end

  def update_payment
    unless credit_card_selected?
      @credit_card = @order.credit_card || current_customer.credit_cards.new
      unless card_have_no_orders?(@credit_card)
        @credit_card = current_customer.credit_cards.new
      end
      @credit_card.attributes = params.require(:credit_card).permit(
        :number, :cvv, :expiration_month, :expiration_year, :first_name, :last_name
      )
      @credit_card.save!
      @order.credit_card = @credit_card
      @order.save
    end
    redirect_to next_wizard_path
  end
  
  private
  
  def card_have_no_orders?(card = nil)
    return false if card === nil
    return card.orders.placed.count == 0
  end
  
  def credit_card_selected?
    order_params = params.permit(order: [:credit_card_id])
    if order_params[:order] && order_params[:order][:credit_card_id]
      @order.update order_params[:order]
    end
  end
end
