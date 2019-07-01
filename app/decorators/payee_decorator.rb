# frozen_string_literal: true

# Decorator for when payee attributes are rendered in views
class PayeeDecorator < Draper::Decorator
  delegate_all

  def website
    h.link_to object.website.truncate(75), object.website
  end

  def phone_number
    h.link_to object.phone_number, "tel:#{object.phone_number}"
  end
end
