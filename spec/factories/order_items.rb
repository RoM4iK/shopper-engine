FactoryGirl.define do
  factory :shopper_engine_order_item, class: 'ShopperEngine::OrderItem' do

    quantity { Faker::Number.between(1, 5) }

    after(:build) do |order_item, evaluator|
      if order_item.product.blank?
        order_item.product = build(:book)
        order_item.price = order_item.product.price
      end
    end

    after(:create) do |order_item, evaluator|
      if order_item.product.blank?
        order_item.product = create(:book)
        order_item.price = order_item.book.price
      end
    end
  end
end
