module ShopperEngine
  class Cart < ShopperEngine::Order
    def add_item(product, quantity = 1)
        quantity = quantity.to_i unless quantity.is_a?(Fixnum)
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
      quantity = quantity.to_i unless quantity.is_a?(Fixnum)
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

    def place!
      state = self::SHIPPING
      placed_at = Time.now
      save!
    end

  end
end
