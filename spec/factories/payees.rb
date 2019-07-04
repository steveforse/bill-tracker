# frozen_string_literal: true

FactoryBot.define do
  factory :payee do
    name { Faker::Company.name }
    nickname { Faker::Commerce.product_name }
    website { Faker::Internet.url }
    phone_number { Faker::PhoneNumber.phone_number }
    description { Faker::Quote.famous_last_words }

    trait :with_schedules do
      after(:create) do |instance|
        create_list :schedule, 2, payee: instance
      end
    end
  end
end
