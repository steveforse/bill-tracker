# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/edit', type: :view do
  let(:payment) { create(:payment) }

  it 'renders the edit payment form' do
    assign(:payment, payment)

    render

    assert_select 'form[action=?][method=?]', payment_path(payment), 'post' do
      assert_select 'input[name=?]', 'payment[date]'
      assert_select 'input[name=?]', 'payment[due_date]'
      assert_select 'input[name=?]', 'payment[amount]'
      assert_select 'textarea[name=?]', 'payment[comment]'
    end
  end
end
