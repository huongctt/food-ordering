FactoryBot.define do
  factory :order_address do
    association :user
    address {Faker::String.random}
    is_using {true}
  end
end
