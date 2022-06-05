require 'rails_helper'

RSpec.describe PaymentRequests::RejectionWorker, type: :worker do
  describe 'valid message' do
    it 'rejects payment request' do
      payment_request = create(:payment_request_record)
      payload = { id: payment_request.id }.to_json
      options = { routing_key: 'payment_request.rejected' }

      worker = PaymentRequests::RejectionWorker.new
      worker.work_with_params(payload, options, { message_id: SecureRandom.hex })

      payment_request.reload
      expect(payment_request.rejected?).to be_truthy
    end
  end
end