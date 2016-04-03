module ShopperEngine
  module ActsAsProduct
   extend ActiveSupport::Concern
    module ClassMethods
      def acts_as_product
        class_name = self.to_s.underscore
        ShopperEngine::PRODUCT_CLASSES.push(class_name).uniq!
        send(:has_many, :order_items, {
          class_name: 'ShopperEngine::OrderItem',
          as: :product
        })

        product_methods(self)
      end
      private
      def product_methods(product_class)
        self.class_eval do
          def product_type
            self.class.to_s.underscore
          end
        end
      end
    end
  end
end
