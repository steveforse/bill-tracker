# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayeeDecorator do
  let(:payee) do
    build(:payee).decorate
  end

  describe '#website' do
    it 'renders website as a link' do
      url = 'https://www.google.com'
      payee.website = url
      expect(payee.website).to have_link(href: url, exact_text: url)
    end
  end

  describe '#phone_number' do
    it 'renders phone number as a link' do
      phone_number = '555-555-5555'
      payee.phone_number = phone_number
      expect(payee.phone_number).to have_link(href: ('tel:' + phone_number),
                                              exact_text: phone_number)
    end
  end
end
