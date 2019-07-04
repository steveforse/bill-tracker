# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'payees/edit', type: :view do
  let(:payee) { create(:payee) }

  it 'renders the edit payee form' do
    assign(:payee, payee)

    render

    assert_select 'form[action=?][method=?]', payee_path(payee), 'post' do
      assert_select 'div.form-inputs', count: 1 do
        assert_select 'input', count: 4
        assert_select 'textarea', count: 1
        assert_select 'input[name="payee[name]"]', count: 1
        assert_select 'input[name="payee[nickname]"]', count: 1
        assert_select 'input[name="payee[website]"]', count: 1
        assert_select 'input[name="payee[phone_number]"]', count: 1
        assert_select 'textarea[name="payee[description]"]', count: 1
      end

      assert_select 'div.form-actions', count: 1 do
        assert_select 'input.btn.btn-primary[type=submit][value="Update Payee"]', count: 1
        assert_select 'button.btn.btn-outline-secondary[type=reset]', count: 1, text: 'Reset Form'
        assert_select "a.btn.btn-outline-secondary[href='/payees/#{payee.id}']",
                      count: 1, text: 'Back to Payee Details'
      end
    end
  end
end
