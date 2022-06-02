require 'rails_helper'

RSpec.describe PaymentRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/payment_requests').to route_to('payment_requests#index')
    end

    it 'routes to #new' do
      expect(get: '/payment_requests/new').to route_to('payment_requests#new')
    end

    it 'routes to #show' do
      expect(get: '/payment_requests/1').to route_to('payment_requests#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/payment_requests/1/edit').to route_to('payment_requests#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/payment_requests').to route_to('payment_requests#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/payment_requests/1').to route_to('payment_requests#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/payment_requests/1').to route_to('payment_requests#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/payment_requests/1').to route_to('payment_requests#destroy', id: '1')
    end
  end
end
