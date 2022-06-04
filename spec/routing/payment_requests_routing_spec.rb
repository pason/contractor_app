require 'rails_helper'

RSpec.describe PaymentRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/payment_requests').to route_to('payment_requests#index')
    end

    it 'routes to #new' do
      expect(get: '/payment_requests/new').to route_to('payment_requests#new')
    end

    it 'routes to #create' do
      expect(post: '/payment_requests').to route_to('payment_requests#create')
    end
  end
end
