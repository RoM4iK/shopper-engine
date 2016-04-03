FactoryGirl.define do
  factory :customer, class: Customer do
    email { Faker::Internet.safe_email }
  end
end
