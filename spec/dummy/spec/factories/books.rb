FactoryGirl.define do
  factory :book, class: Book do
    price { Faker::Number.between(1, 100) }
    title { Faker::Book.title }
  end
end
