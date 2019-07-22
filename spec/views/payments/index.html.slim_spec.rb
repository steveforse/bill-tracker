# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/index', type: :view do
  before do
    assign(:payments, [
             Payment.create!(
               schedule_id: 2,
               amount: '',
               comment: 'MyText'
             ),
             Payment.create!(
               schedule_id: 2,
               amount: '',
               comment: 'MyText'
             )
           ])
  end

  it 'renders a list of payments' do
    render
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
