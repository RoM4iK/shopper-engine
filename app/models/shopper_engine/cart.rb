module ShopperEngine
  class Cart < ShopperEngine::Order
    def add_item(product, quantity = 1)
        order_item = order_items.find_by({product: product})
        if (order_item)
           order_item.update_quantity(order_item.quantity + quantity)
           order_item.save
        else
            order_items.create({product: product, quantity: quantity, price: product.price * quantity})
        end
        update_price!
    end

    def update_quantity(order_item, quantity)
      if (quantity <= 0)
        order_item.delete
      else
        order_item.update_quantity(quantity)
        order_item.save
      end
      update_price!
    end


    def update_price!
        self.price = order_items.sum("price")
        save
    end

    def self.current_cart
      if current_customer.present?
        cart_for_logged_user
      else
        cart_for_unlogged_user
      end
    end

    private

    def cart_for_logged_user
      if (session[:cart_id])
        cart = update_customer_cart
      else
        cart = current_customer.current_cart
      end
      cart
    end

    def cart_for_unlogged_user
      if (session[:cart_id])
        cart = cart_from_session
      else
        cart = store_cart_to_session
      end
      cart
    end

    def cart_from_session
      find(session[:cart_id])
    end

    def store_cart_to_session
      cart = create!(state: self::PAYMENT)
      session[:cart_id] = cart.id
      cart
    end

    def update_customer_cart
      current_customer.current_cart.delete
      cart = cart_from_session
      cart.customer = current_customer
      cart.save
      session[:cart_id] = nil
      cart
    end
  end
end
