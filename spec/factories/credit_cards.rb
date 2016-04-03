FactoryGirl.define do
  factory :shopper_engine_credit_card, class: 'ShopperEngine::CreditCard' do
    transient do
      order_items_count 1
    end

    date = Faker::Date.between(2.days.ago, Date.today)

    number { Faker::Number.number(16) }
    cvv { Faker::Number.number(3) }
    expiration_month { date.month }
    expiration_year { date.year }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    after(:build) do |credit_card, evaluator|
      if credit_card.customer.blank?
        credit_card.customer = build(:customer)
      end
    end

    after(:create) do |credit_card, evaluator|
      if credit_card.customer.blank?
        credit_card.customer = create(:customer)
      end
    end
  end
end
