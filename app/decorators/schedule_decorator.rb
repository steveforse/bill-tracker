# frozen_string_literal: true

# Decorator for when schedules are rendered in views
class ScheduleDecorator < Draper::Decorator
  delegate_all

  def autopay
    object.autopay ? 'Enabled' : 'Disabled'
  end

  def minimum_payment
    h.number_to_currency(object.minimum_payment, precision: 2)
  end

  def frequency
    Schedule.frequencies[object.frequency]
  end
end
