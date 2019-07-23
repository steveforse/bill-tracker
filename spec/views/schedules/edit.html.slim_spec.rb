# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'schedules/edit', type: :view do
  let(:schedule) { create(:schedule) }

  it 'renders the edit schedule form' do
    assign(:schedule, schedule)

    render

    assert_select 'form[action=?][method=?]', schedule_path(schedule), 'post' do
      assert_select 'div.form-inputs', count: 1 do
        assert_select 'input', count: 6

        assert_select 'label', text: 'Name *'
        assert_select 'input[name="schedule[name]"]'

        assert_select 'label', text: 'Start date *'
        assert_select 'input[name="schedule[start_date]"]'

        assert_select 'label', text: 'End date'
        assert_select 'input[name="schedule[end_date]"]'

        assert_select 'label', text: 'Frequency'
        assert_select 'select[name="schedule[frequency]"]' do
          assert_select 'optgroup', count: 3
          assert_select 'option', count: 9
        end

        assert_select 'label', text: 'Minimum payment'
        assert_select 'input[type=number][name="schedule[minimum_payment]"]'

        assert_select 'label', text: 'Frequency'
        assert_select 'input[type=hidden][name="schedule[autopay]"]'
        assert_select 'input[data-toggle=toggle][name="schedule[autopay]"]'
      end

      assert_select 'div.form-actions', count: 1 do
        assert_select 'input.btn.btn-primary[type=submit][value="Update Schedule"]', count: 1
        assert_select 'button.btn.btn-outline-secondary[type=reset]', text: 'Reset Form', count: 1
        assert_select "a.btn.btn-outline-secondary[href='/payees/#{schedule.payee.id}']",
                      text: 'Back to Payee', count: 1
      end
    end
  end
end
