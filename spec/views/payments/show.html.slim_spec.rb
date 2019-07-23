# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/show', type: :view do
  before do
    @payment = assign(:payment, create(:payment))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2/)
  end
end
