require 'rails_helper'

RSpec.describe PaymentRequests::AcceptanceWorker, type: :worker do
  describe 'valid message' do
    it 'accepts payment request' do
      payment_request = create(:payment_request_record)
      payload = { id: payment_request.id }.to_json
      options = { routing_key: 'payment_request.accepted' }

      worker = PaymentRequests::AcceptanceWorker.new
      worker.work_with_params(payload, options, { message_id: SecureRandom.uuid })

      payment_request.reload
      expect(payment_request.accepted?).to be_truthy
    end
  end
end