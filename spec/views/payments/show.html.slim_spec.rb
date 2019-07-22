# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/show', type: :view do
  before do
    @payment = assign(:payment, Payment.create!(
                                  schedule_id: 2,
                                  amount: '',
                                  comment: 'MyText'
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2/)
  end
end
