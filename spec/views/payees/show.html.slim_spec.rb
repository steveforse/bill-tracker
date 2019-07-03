# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payees/show', type: :view do
  let(:payee) { create(:payee) }

  it 'renders attributes in <p>' do
    assign(:payee, payee)
    assign(:schedules, payee.schedules)

    render
  end
end
