# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payees/show', type: :view do
  before do
    payee = create(:payee, :with_schedules)

    assign(:payee, payee.decorate)
    assign(:schedules, payee.schedules
                            .rezort(params[:sort], 'start_date ASC')
                            .page(params[:page])
                            .decorate)

    # Needed for rezort links
    controller.request.params['id'] = payee.id

    render
  end

  let(:payee) { Payee.first }
  let(:schedules) { payee.schedules.rezort(params[:sort], 'start_date ASC') }

  it 'renders decorated payee details' do
    assert_select '.card-header .h4', text: 'Payee Details'

    assert_select '.card-body' do
      assert_select '.row:nth-of-type(1) .col-form-label', text: 'Name'
      assert_select '.row:nth-of-type(1) .form-control-plaintext', text: payee.name

      assert_select '.row:nth-of-type(2) .col-form-label', text: 'Nickname'
      assert_select '.row:nth-of-type(2) .form-control-plaintext', text: payee.nickname

      assert_select '.row:nth-of-type(3) .col-form-label', text: 'Website'
      assert_select '.row:nth-of-type(3) .form-control-plaintext' do
        assert_select "a[href='#{payee.website}']", text: payee.website.truncate(30)
      end

      assert_select '.row:nth-of-type(4) .col-form-label', text: 'Phone Number'
      assert_select '.row:nth-of-type(4) .form-control-plaintext' do
        assert_select "a[href='tel:#{payee.phone_number}']", text: payee.phone_number
      end

      assert_select '.row:nth-of-type(5) .col-form-label', text: 'Description'
      assert_select '.row:nth-of-type(5)  pre.scrollable', text: payee.description
    end
  end

  it 'renders payee action buttons' do
    assert_select '.card-body .row:nth-of-type(6)' do
      assert_select "a.btn.btn-primary[href='/payees/#{payee.id}/edit']", text: 'Edit Payee'
      assert_select "a.btn.btn-danger[href='/payees/#{payee.id}'][data-method=delete]",
                    text: 'Delete Payee'
      assert_select "a.btn.btn-outline-secondary[href='/payees']", text: 'Back to Payees List'
    end
  end

  it 'renders schedules card header' do
    assert_select '.card-header .h4', text: 'Schedules'
    assert_select ".card-header a[href='/payees/#{payee.id}/schedules/new']", text: 'New Schedule'
  end

  it 'renders schedules table header' do
    assert_select 'table.table' do
      assert_select 'thead tr' do
        assert_select 'th', count: 7
        assert_select 'th a.rezort', text: 'Name'
        assert_select 'th a.rezort', text: 'Start Date'
        assert_select 'th a.rezort', text: 'End Date'
        assert_select 'th a.rezort', text: 'Frequency'
        assert_select 'th a.rezort', text: 'Autopay'
        assert_select 'th a.rezort', text: 'Minimum Payment'
        assert_select 'th', text: 'Actions'
      end
    end
  end

  it 'renders schedules' do
    assert_select 'table.table' do
      payee.schedules.order(start_date: :asc).each_with_index do |schedule, i|
        assert_select "tr:nth-of-type(#{i + 1})" do
          assert_select 'td:nth-of-type(1)', text: schedule.name
          assert_select 'td:nth-of-type(2)', text: schedule.start_date.to_s
          assert_select 'td:nth-of-type(3)', text: schedule.end_date.to_s
          assert_select 'td:nth-of-type(4)', text: Schedule.frequencies[schedule.frequency][:description]
          assert_select 'td:nth-of-type(5)', text: (schedule.autopay ? 'Enabled' : 'Disabled')
          assert_select 'td:nth-of-type(6)', text: number_to_currency(schedule.minimum_payment)
          assert_select 'td:nth-of-type(7)' do
            assert_select "a.btn.btn-primary[href='/schedules/#{schedule.id}']", text: 'Details'
          end
        end
      end
    end
  end
end
