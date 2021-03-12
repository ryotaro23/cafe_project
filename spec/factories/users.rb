FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    university { Faker::Lorem.characters(number: 10) }
    university { Faker::Lorem.characters(number: 10) }
    password { 'password' }
    password_confirmation { 'password' }
    grade { 1 }
  end
end
