FactoryBot.define do
  factory :place do
    address { 'Towarowa 2, Warszawa, Polska' }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }
  end
end
