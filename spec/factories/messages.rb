FactoryBot.define do
  factory :message do
    body { Faker::Lorem.characters(number: 10) }
  end
end
