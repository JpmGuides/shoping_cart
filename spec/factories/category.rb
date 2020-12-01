FactoryBot.define do
  factory :category do
    client
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end
