FactoryBot.define do
  factory :order_item do
    order
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end
