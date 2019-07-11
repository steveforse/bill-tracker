# frozen_string_literal: true

  json.array! (1..4).to_a do |id|
    json.title Faker::Company.industry
    json.color '#ff9f89'

    json.extendedProps do
      json.id rand(1..100)
      json.company Faker::Company.name
    end

    json.rrule do
      json.freq ['weekly', 'monthly'].sample
      json.interval rand(1..4)
      json.dtstart Faker::Date.between(8.days.ago, Time.zone.today)
    end
  end
