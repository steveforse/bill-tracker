# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'schedules/show', type: :view do
  before do
    schedule = create(:schedule, :with_payments)

    assign(:schedule, schedule.decorate)
    assign(:payments, schedule.payments
                            .rezort(params[:sort], 'date ASC')
                            .page(params[:page])
                            .decorate)

    # Needed for rezort links
    controller.request.params['id'] = schedule.id

    render
  end

  let(:schedule) { Schedule.first }
  let(:payments) { schedule.payments.rezort(params[:sort], 'date ASC') }

  it 'renders decorated schedule details' do
    assert_select '.card-header .h4', text: 'Schedule Details'

    assert_select '.card-body' do
      assert_select '.row:nth-of-type(1) .col-form-label', text: 'Name'
      assert_select '.row:nth-of-type(1) .form-control-plaintext', text: schedule.name

      assert_select '.row:nth-of-type(2) .col-form-label', text: 'Start Date'
      assert_select '.row:nth-of-type(2) .form-control-plaintext', text: schedule.start_date.to_s

      assert_select '.row:nth-of-type(3) .col-form-label', text: 'End Date'
      assert_select '.row:nth-of-type(3) .form-control-plaintext', text: schedule.end_date.to_s

      assert_select '.row:nth-of-type(4) .col-form-label', text: 'Frequency'
      assert_select '.row:nth-of-type(4) .form-control-plaintext',
                    text: Schedule.frequencies[schedule.frequency][:description]

      assert_select '.row:nth-of-type(5) .col-form-label', text: 'Autopay'
      assert_select '.row:nth-of-type(5) .form-control-plaintext',
                    text: (schedule.autopay? ? 'Enabled' : 'Disabled')

      assert_select '.row:nth-of-type(6) .col-form-label', text: 'Minimum Payment'
      assert_select '.row:nth-of-type(6) .form-control-plaintext',
                    text: number_to_currency(schedule.minimum_payment)
    end
  end

  it 'renders schedule action buttons' do
    assert_select '.card-body .row:nth-of-type(7)' do
      assert_select "a.btn.btn-primary[href='/schedules/#{schedule.id}/edit']",
                    text: 'Edit Schedule'
      assert_select "a.btn.btn-danger[href='/schedules/#{schedule.id}'][data-method=delete]",
                    text: 'Delete Schedule'
      assert_select "a.btn.btn-outline-secondary[href='/payees/#{schedule.payee.id}']",
                    text: 'Back to Payee Details'
    end
  end

  it 'renders payments card header' do
    assert_select '.card-header .h4', text: 'Payments'
    assert_select ".card-header a[href='/schedules/#{schedule.id}/payments/new']",
                  text: 'New Payment'
  end

  it 'renders payments table header' do
    assert_select 'table.table' do
      assert_select 'thead tr' do
        assert_select 'th', count: 5
        assert_select 'th a.rezort', text: 'Date'
        assert_select 'th a.rezort', text: 'Due Date'
        assert_select 'th a.rezort', text: 'Amount'
        assert_select 'th a.rezort', text: 'Comment'
        assert_select 'th', text: 'Actions'
      end
    end
  end

  it 'renders payments' do
    assert_select 'table.table' do
      schedule.payments.order(date: :asc).each_with_index do |payment, i|
        assert_select "tr:nth-of-type(#{i + 1})" do
          assert_select 'td:nth-of-type(1)', text: payment.date.to_s
          assert_select 'td:nth-of-type(2)', text: payment.due_date.to_s
          assert_select 'td:nth-of-type(3)', text: number_to_currency(payment.amount)
          assert_select 'td:nth-of-type(4)', text: payment.comment
          assert_select 'td:nth-of-type(5)' do
            assert_select "a.btn.btn-primary[href='/payments/#{payment.id}/edit']",
                          text: 'Edit Payment'
            assert_select "a.btn.btn-danger[href='/payments/#{payment.id}'][data-method=delete]",
                          text: 'Delete Payment'
          end
        end
      end
    end
  end
end
