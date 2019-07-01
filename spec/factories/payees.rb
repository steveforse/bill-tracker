# frozen_string_literal: true

FactoryBot.define do
  factory :payee do
    name { Faker::Company.name }
    nickname { Faker::Commerce.product_name }
    website { Faker::Internet.url }
    phone_number { Faker::PhoneNumber.phone_number }
    description { Faker::Quote.famous_last_words }
  end
end
