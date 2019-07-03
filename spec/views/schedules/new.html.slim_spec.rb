# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'schedules/new', type: :view do
  let(:schedule) { build(:schedule, payee: create(:payee)) }

  it 'renders new schedule form' do
    assign(:schedule, schedule)
    assign(:payee, schedule.payee)

    render

    assert_select 'form[action=?][method=?]', payee_schedules_path(schedule.payee), 'post' do
    end
  end
end
