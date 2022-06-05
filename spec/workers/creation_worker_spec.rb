require 'rails_helper'

RSpec.describe PaymentRequests::CreationWorker, type: :worker do
  let(:valid_payload) do
    { id: SecureRandom.hex, amount: 1000, currency_code: 'USD', description: 'payment' }.to_json
  end

  describe 'valid message' do
    it 'creates payment request' do
      options = { routing_key: 'payment_request.created' }

      worker = PaymentRequests::CreationWorker.new

      expect {
       worker.work_with_params(valid_payload, options, { message_id: SecureRandom.hex })
      }.to change(PaymentRequestRecord, :count).by(1)
       .and change(Events::PaymentRequest::Created, :count).by(1)


    end
  end
end