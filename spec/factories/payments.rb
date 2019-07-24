# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    schedule
    amount { Faker::Number.decimal(4, 2) }
    comment { Faker::Movies::PrincessBride.quote }
    due_date { schedule.start_date + 3.months }
    date { rand((due_date - 3.days)..(due_date + 3.days)) }
  end
end
