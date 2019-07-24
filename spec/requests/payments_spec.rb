# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  describe 'GET /schedules/:schedule_id/payments' do
    let(:schedule) { create(:schedule) }

    it 'works! (now write some real specs)' do
      get schedule_payments_path(schedule)
      expect(response).to have_http_status(:ok)
    end
  end
end
