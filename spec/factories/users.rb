FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.first_name }
    email { Faker::Internet.safe_email }
    password { 'password' }
    confirmed_at { Faker::Time.backward }
  end
end
