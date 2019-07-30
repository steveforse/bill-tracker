# frozen_string_literal: true

every 1.day, at: '3:00 am' do
  runner 'Schedule.generate_autopayments'
end
