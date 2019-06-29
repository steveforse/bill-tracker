json.extract! schedule, :id, :payee_id, :start_date, :end_date, :due_date, :frequency, :autopay, :minimum_payment, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)
