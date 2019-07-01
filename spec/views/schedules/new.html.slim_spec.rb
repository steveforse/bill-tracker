# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'schedules/new', type: :view do
  let(:schedule) do
    create(:scedule)
  end

  it 'renders new schedule form' do
    render

    assert_select 'form[action=?][method=?]', payee_schedules_path(schedule.payee), 'post' do
    end
  end
end
