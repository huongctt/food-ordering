FactoryBot.define do
  factory :order do
    association :user
    status{2}
  end
end
