require 'rails_helper'

RSpec.describe PaymentRequests::AcceptanceWorker, type: :worker do
  include_context 'sneakers_publish_inline'

  describe 'receives message' do
    it 'accepts payment request' do
      payment_request = PaymentRequestRecord.create!(amount: 1000, currency_code: 'USD', description: 'payment')
      payload = { guid: payment_request.guid }.to_json
      options = { routing_key: 'payment_request.accepted',
                  topic: Rails.application.credentials.config.dig(:amqp, :exchange)}

      worker = PaymentRequests::AcceptanceWorker.new
      worker.work_with_params(payload, options, 'x')


      payment_request.reload
      expect(payment_request.accepted?).to be_truthy
    end
  end
end