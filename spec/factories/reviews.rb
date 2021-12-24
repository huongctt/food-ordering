FactoryBot.define do
  factory :review do
    association :food
    association :user
    rate {Faker::Number.positive}
    comment {Faker::String.random(length: [2, 100])}
  end
end
