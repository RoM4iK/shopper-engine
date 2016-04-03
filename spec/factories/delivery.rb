FactoryGirl.define do
  factory :shopper_engine_delivery, class: 'ShopperEngine::Delivery' do
    name { Faker::Company.name }
    description { Faker::Company.buzzword }
    price { Faker::Commerce.price }
  end
end
