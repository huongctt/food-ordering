FactoryBot.define do
  factory :order_item do
    association :order
    association :food
    association :user
    quantity {Faker::Number.positive}
  end
end
