FactoryGirl.define do
  factory :shopper_engine_country, class: 'ShopperEngine::Country' do
    name { Faker::Address.country }
  end
end
