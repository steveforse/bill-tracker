# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe PayeesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/payees').to route_to('payees#index')
    end

    it 'routes to #new' do
      expect(get: '/payees/new').to route_to('payees#new')
    end

    it 'routes to #show' do
      expect(get: '/payees/1').to route_to('payees#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/payees/1/edit').to route_to('payees#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/payees').to route_to('payees#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/payees/1').to route_to('payees#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/payees/1').to route_to('payees#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/payees/1').to route_to('payees#destroy', id: '1')
    end
  end
end
# rubocop: enable Metrics/BlockLength
