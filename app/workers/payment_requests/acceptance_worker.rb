module PaymentRequests
  class AcceptanceWorker
    include Sneakers::Worker

    from_queue 'contractor_payment_request_accepted',
               routing_key: 'payment_request.accepted',
               durable: true

    def work_with_params(msg, _delivery_info, metadata)
      payload = ActiveSupport::JSON.decode(msg)&.with_indifferent_access
      message_id = metadata[:message_id]
      payment_request_record_id = payload[:id]
      payment_request_record = PaymentRequestRecord.find(payment_request_record_id)

      ActiveRecord::Base.transaction do
        Events::PaymentRequest::Accepted.create!(payment_request_record: payment_request_record,
                                                 message_id: message_id)
        payment_request_record.accepted!
      end

      ack!
    end
  end
end
