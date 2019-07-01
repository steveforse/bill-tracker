# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'schedules/new', type: :view do
  before do
    @payee = assign(:payee, create(:payee))
    @schedule = assign(:schedule, build(:schedule, payee: @payee))
  end

  it 'renders new schedule form' do
    render

    assert_select 'form[action=?][method=?]', payee_schedules_path(@payee), 'post' do
    end
  end
end
