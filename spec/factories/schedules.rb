# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    name { Faker::Commerce.product_name }
    start_date { Faker::Date.between(1.year.ago, Time.zone.today).change(day: rand(1..28)) }
    end_date { start_date + 1.year }
    frequency { Schedule.frequencies.keys.sample }
    autopay { Faker::Boolean.boolean }
    minimum_payment { Faker::Number.decimal(4, 2) }
    payee
  end

  trait :with_payments do
    after(:create) do |instance|
      create_list :payment, 2, schedule: instance
    end
  end
end
