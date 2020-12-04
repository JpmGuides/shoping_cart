FactoryBot.define do
  factory :order do
    client
    reference { Faker::Barcode.ean(8) }
  end
end
