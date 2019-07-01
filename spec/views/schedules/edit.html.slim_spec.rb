# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'schedules/edit', type: :view do
  let(:schedule) do
    create(:schedule)
  end

  it 'renders the edit schedule form' do
    render

    assert_select 'form[action=?][method=?]', schedule_path(schedule), 'post' do
    end
  end
end
