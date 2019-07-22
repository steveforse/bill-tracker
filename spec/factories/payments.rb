# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    schedule_id { 1 }
    amount { '' }
    date { '2019-07-05' }
    comment { 'MyText' }
    due_on { '2019-07-05' }
  end
end
