FactoryGirl.define do
  factory :shopper_engine_address, class: 'ShopperEngine::Address' do
    address { Faker::Address.street_address }
    zipcode { Faker::Number.number(5) }
    city { Faker::Address.city}
    phone { Faker::Number.number(8) }

    after(:build) do |address, evaluator|
      if address.customer.blank?
        address.customer = build(:customer)
      end
      if address.country.blank?
        address.country = FactoryGirl.build(:shopper_engine_country)
      end
    end

    after(:create) do |address, evaluator|
      if address.customer.blank?
        address.customer = create(:customer)
      end
      if address.country.blank?
        address.country = FactoryGirl.create(:shopper_engine_country)
      end
    end
  end
end
