class OrdersController < ApplicationController
  include ApplicationHelper
  before_action: :authenticate_customer!

  def index
    @orders = current_customer.orders.placed.all
  end
end
