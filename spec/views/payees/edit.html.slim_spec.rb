# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payees/edit', type: :view do
  let(:payee) do
    create(:payee)
  end

  it 'renders the edit payee form' do
    render

    assert_select 'form[action=?][method=?]', payee_path(payee), 'post' do
    end
  end
end
