# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    start_date { Faker::Date.between(1.year.ago, Time.zone.today).change(day: rand(1..28)) }
    end_date { Faker::Date.between(Date.tomorrow, 1.year.from_now) }
    frequency { Schedule.frequencies.keys.sample }
    autopay { Faker::Boolean.boolean }
    minimum_payment { Faker::Number.decimal(4, 2) }
    payee
  end
end
