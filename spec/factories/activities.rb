FactoryBot.define do
  factory :activity do
    user_id { 1 }
    distance { 10000 }
    start_id { 1 }
    finish_id { 1 }
    day { Date.today }
  end
end
