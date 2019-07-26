# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/schedules/1/payments/new').to route_to('payments#new', schedule_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/payments/1/edit').to route_to('payments#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/schedules/1/payments').to route_to('payments#create', schedule_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/payments/1').to route_to('payments#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/payments/1').to route_to('payments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/payments/1').to route_to('payments#destroy', id: '1')
    end
  end
end
