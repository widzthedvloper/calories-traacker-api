FactoryBot.define do
  factory :ingredient do
    name { Faker::Lorem.word }
    calorie { Faker::Number.number(100) }
    food_id nil
  end
end
