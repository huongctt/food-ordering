FactoryBot.define do
  factory :food do
    association :category
    name { Faker::Name.name }
    price { Faker::Number.positive }
    description { Faker::String.random(length: [2, 100]) }
  end
end
