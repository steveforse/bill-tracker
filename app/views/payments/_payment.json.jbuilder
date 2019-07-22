# frozen_string_literal: true

json.extract! payment, :id, :schedule_id, :amount, :date, :comment, :due_date, :created_at,
              :updated_at
json.url payment_url(payment, format: :json)
