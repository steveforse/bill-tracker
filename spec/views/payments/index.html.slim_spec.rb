# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/index', type: :view do
  let(:schedules) { create_list(:schedule, 10) }
  let(:payments) do
    create_list(:payment, 10, schedule: schedules.sample)
    Payment.all.rezort(params[:sort], 'date DESC').page(params[:page]).decorate
  end

  before do
    assign(:payments, payments)
    render
  end

  it 'renders card with payments' do
    assert_select '.card-header .h4', text: 'Payments'
    assert_select '.card-body' do
      assert_select 'table.table' do
        assert_select 'thead tr' do
          assert_select 'th', count: 5
          assert_select 'th a.rezort', text: 'Payee'
          assert_select 'th a.rezort', text: 'Schedule'
          assert_select 'th a.rezort', text: 'Date'
          assert_select 'th a.rezort', text: 'Due Date'
          assert_select 'th a.rezort', text: 'Amount'
        end
        assert_select 'tbody' do
          payments.each do |payment|
            assert_select 'tr' do
              assert_select 'td:nth-of-type(1)', text: payment.schedule.payee.name
              assert_select 'td:nth-of-type(2)', text: payment.schedule.name
              assert_select 'td:nth-of-type(3)', text: payment.date.to_s
              assert_select 'td:nth-of-type(4)', text: payment.due_date.to_s
              assert_select 'td:nth-of-type(5)', text: payment.amount
            end
          end
        end
      end
    end
  end
end
