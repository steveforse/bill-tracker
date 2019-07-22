# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/edit', type: :view do
  let(payment) { assign(:payment, Payment.create!(schedule_id: 1, amount: '', comment: 'text')) }

  it 'renders the edit payment form' do
    render

    assert_select 'form[action=?][method=?]', payment_path(payment), 'post' do
      assert_select 'input[name=?]', 'payment[schedule_id]'

      assert_select 'input[name=?]', 'payment[amount]'

      assert_select 'textarea[name=?]', 'payment[comment]'
    end
  end
end
