module PaymentRequests
  class AcceptanceWorker
    include Sneakers::Worker

    from_queue 'contractor_payment_request_accepted',
               routing_key: 'payment_request.accepted',
               durable: true

    def work_with_params(_msg, _delivery_info, metadata)
      message_id = metadata[:message_id]
      event = Events::PaymentRequestEvent.find(message_id)
      payment_request_record = event.payment_request_record

      ActiveRecord::Base.transaction do
        Events::PaymentRequest::Accepted.create!(payment_request_record: payment_request_record,
                                                 message_id: message_id)
        payment_request.accepted!
      end

      ack!
    end
  end
end
