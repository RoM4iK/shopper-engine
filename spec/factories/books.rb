FactoryGirl.define do
  factory :book, class: Book do
    price { Faker::Number.between(1, 100) }
    quantity { Faker::Number.between(0, 10) }
    title { Faker::Book.title }
  end
end
