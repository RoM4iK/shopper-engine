module ShopperEngine
  module ActsAsCustomer
   extend ActiveSupport::Concern
    module ClassMethods
      def acts_as_customer(scope: :user)
        send(:has_many, :orders, {
          class_name: 'ShopperEngine::Order'
        })
        send(:has_many, :addresses, {
          class_name: 'ShopperEngine::Address'
        })
        send(:has_many, :credit_cards, {
          class_name: 'ShopperEngine::CreditCard'
        })
        ShopperEngine::set_devise_scope(scope.downcase)
      end
    end
  end
end
