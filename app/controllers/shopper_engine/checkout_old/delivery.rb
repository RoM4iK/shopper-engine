module Checkout::Delivery
  def update_delivery
    begin
      @order.update params.require(:order).permit(:delivery_id)
      redirect_to next_wizard_path
    rescue ActionController::ParameterMissing
      flash.now[:alert] = "You must select delivery method"
      render_wizard
    end
  end
end