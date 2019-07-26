# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentDecorator do
  let(:payment) do
    build(:payment).decorate
  end

  describe '#amount' do
    it 'renders amount as currency' do
      payment.amount= 42.3
      expect(payment.amount).to eq('$42.30')
    end
  end
end
