FactoryBot.define do
  factory :category do
    client
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    reference { Faker::Barcode.ean(8) }
  end
end
