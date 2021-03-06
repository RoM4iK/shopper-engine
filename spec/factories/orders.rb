FactoryGirl.define do
  factory :shopper_engine_order, class: 'ShopperEngine::Order' do
    transient do
      order_items_count 1
    end

    state { Faker::Number.number(1) }

    after(:build) do |order, evaluator|
      if order.customer.blank?
        order.customer = build(:customer)
      end
      if order.credit_card.blank?
        order.credit_card = build(:shopper_engine_credit_card, customer: order.customer)
      end
    end

    after(:create) do |order, evaluator|
      if order.customer.blank?
        order.customer = create(:customer)
      end
      if order.credit_card.blank?
        order.credit_card = create(:shopper_engine_credit_card, customer: order.customer)
      end
      if order.order_items.blank?
        order_items = create_list(:shopper_engine_order_item,
          evaluator.order_items_count)
        order.order_items << order_items
      end
    end
  end
end
