FactoryBot.define do
  factory :product do
    client
    category
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    reference { Faker::Barcode.ean(8) }
  end
end
