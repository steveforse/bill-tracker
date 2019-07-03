# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payees/edit', type: :view do
  let(:payee) { create(:payee) }

  it 'renders the edit payee form' do
    assign(:payee, payee)

    render

    assert_select 'form[action=?][method=?]', payee_path(payee), 'post' do
    end
  end
end
