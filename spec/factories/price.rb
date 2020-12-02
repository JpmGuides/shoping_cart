FactoryBot.define do
  factory :price do
    product
    name { Faker::Lorem.word }
    price { Faker::Number.decimal(l_digits: 2) }
  end
end
