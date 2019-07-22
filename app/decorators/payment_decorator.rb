# frozen_string_literal: true

# Mostly for amounts
class PaymentDecorator < ApplicationDecorator
  delegate_all

  def amount
    h.number_to_currency(object.amount, precision: 2)
  end
end
