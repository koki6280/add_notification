FactoryBot.define do
  factory :event do
    title { Faker::Lorem.characters(number: 10) }
    event_body { Faker::Lorem.characters(number: 10) }
    start_date { '2020-10-01 23:59:60 +0000' }
    end_date { '2020-10-01 23:59:60 +0000' }
  end
end
