# frozen_string_literal: true

# Decorator for when payee attributes are rendered in views
class PayeeDecorator < ApplicationDecorator
  delegate_all

  def website
    return '' if object.website.blank?
    h.link_to object.website.truncate(30), object.website
  end

  def phone_number
    return '' if object.phone_number.blank?
    h.link_to object.phone_number, "tel:#{object.phone_number}"
  end
end
