# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength
json.array! @schedules.each do |schedule|
  payee = schedule.payee
  json.title schedule.name
  json.rrule schedule.rrule_string

  json.extendedProps do
    json.schedule_id schedule.id
    json.payee do
      json.id payee.id
      json.name payee.name
      json.nickname payee.nickname
      json.website payee.website
      json.phone_number payee.phone_number
    end

    json.payments do
      json.array! schedule.payments.where(due_date: @start_date..@end_date).each do |payment|
        json.due_date payment.due_date
        json.date payment.date
        json.amount payment.amount
        json.comment payment.comment
      end
    end
    json.minimum_payment schedule.minimum_payment
    json.autopay schedule.autopay
    json.start_date schedule.start_date
    json.end_date schedule.end_date
    json.frequency Schedule.frequencies[schedule.frequency][:description]
  end
end
# rubocop: enable Metrics/BlockLength
