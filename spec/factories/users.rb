FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    phone {Faker::PhoneNumber.phone_number}
    password {"123123"}
  end
end
