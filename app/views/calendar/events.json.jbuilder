# frozen_string_literal: true

  json.array! @schedules.each do |schedule|
    payee = schedule.payee
    json.title payee.nickname || payee.name
    json.rrule schedule.rrule_string

    json.extendedProps do
      json.payee do
        json.name payee.name
        json.nickname payee.nickname
        json.website payee.website
        json.phone_number payee.phone_number
      end
      json.minimum_payment schedule.minimum_payment
      json.autopay schedule.autopay
      json.start_date schedule.start_date
      json.end_date schedule.end_date
      json.frequency Schedule.frequencies[schedule.frequency][:description]
    end
  end
