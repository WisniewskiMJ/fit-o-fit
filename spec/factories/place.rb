FactoryBot.define do
  factory :place do
    address { 'Towarowa 1, Warszawa, Polska' }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }
  end
end