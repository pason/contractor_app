module PaymentRequests
  class RejectionWorker
    include Sneakers::Worker

    from_queue 'contractor_payment_request_rejected',
               routing_key: 'payment_request.rejected',
               durable: true

    def work_with_params(_msg, _delivery_info, metadata)
      message_id = metadata[:message_id]
      event = Events::PaymentRequestEvent.find(message_id)
      payment_request = event.payment_request

      ActiveRecord::Base.transaction do
        Events::PaymentRequest::Rejected.create!(payment_request:, message_id:)
        payment_request.rejected!
      end

      ack!
    end
  end
end
