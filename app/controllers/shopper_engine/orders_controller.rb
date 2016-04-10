module ShopperEngine
  class OrdersController < ApplicationController
    include ApplicationHelper
    layout 'layouts/application'
    before_action :authenticate_customer!

    def index
      @orders = current_user.orders.all
    end
  end
end
