FactoryBot.define do
  factory :food do
    name { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end
