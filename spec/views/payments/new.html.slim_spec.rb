# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/new', type: :view do
  let(:payment) { build(:payment, schedule: create(:schedule)) }

  before do
    assign(:payment, payment)
    assign(:schedule, payment.schedule)
  end

  it 'renders new payment form' do
    render

    assert_select 'form[action=?][method=?]', schedule_payments_path(payment.schedule), 'post' do
      assert_select 'input[name=?]', 'payment[date]'
      assert_select 'input[name=?]', 'payment[due_date]'
      assert_select 'input[name=?]', 'payment[amount]'
      assert_select 'textarea[name=?]', 'payment[comment]'
    end
  end
end
