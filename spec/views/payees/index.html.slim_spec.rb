# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payees/index', type: :view do
  before do
    assign(:payees, [
             create(:payee),
             create(:payee)
           ])
  end

  it 'renders a list of payees' do
    render
  end
end
