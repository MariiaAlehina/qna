FactoryBot.define do
  sequence(:email) {|n| "iioior#{n}@example.com" }
  factory :user do
    email
    password '123456'
    password_confirmation '123456'
  end
end