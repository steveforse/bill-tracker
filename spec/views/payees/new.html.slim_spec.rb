# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payees/new', type: :view do
  before do
    assign(:payee, Payee.new)
    render
  end

  let(:payee) { Payee.first }

  it 'renders new payee form' do
    assert_select 'form[action=?][method=?]', payees_path, 'post' do
      assert_select '.form-inputs' do
        assert_select '.row:nth-of-type(1) label', text: 'Name *'
        assert_select ".row:nth-of-type(1) input[name='payee[name]']"

        assert_select '.row:nth-of-type(2) label', text: 'Nickname'
        assert_select ".row:nth-of-type(2) input[name='payee[nickname]']"

        assert_select '.row:nth-of-type(3) label', text: 'Website'
        assert_select ".row:nth-of-type(3) input[name='payee[website]']"

        assert_select '.row:nth-of-type(4) label', text: 'Phone Number'
        assert_select ".row:nth-of-type(4) input[name='payee[phone_number]']"

        assert_select '.row:nth-of-type(5) label', text: 'Description'
        assert_select ".row:nth-of-type(5) textarea[name='payee[description]']"
      end

      assert_select '.form-actions' do
        assert_select "input.btn.btn-primary[type='submit'][value='Create Payee']"
        assert_select "button.btn.btn-outline-secondary[type=reset]", text: 'Reset Form'
        assert_select 'a.btn.btn-outline-secondary[href=\'/payees\']', text: 'Back to Payees List'
      end
    end
  end
end
