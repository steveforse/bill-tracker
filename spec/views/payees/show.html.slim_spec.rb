# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payees/show', type: :view do
  let(:payees) do
    [create(:payee, schedules: [create(:schedule), create(:schedule)]),
     create(:payee, schedules: [create(:schedule), create(:schedule)])]
  end

  it 'renders attributes in <p>' do
    render
  end
end
