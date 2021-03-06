module PaymentRequests
  class RejectionWorker
    include Sneakers::Worker

    from_queue 'contractor_payment_request_rejected',
               routing_key: 'payment_request.rejected',
               durable: true

    def work_with_params(msg, _delivery_info, metadata)
      payload = ActiveSupport::JSON.decode(msg)&.with_indifferent_access
      message_id = metadata[:message_id]
      payment_request_record_id = payload[:id]

      ActiveRecord::Base.transaction do
        payment_request_record = PaymentRequestRecord.find(payment_request_record_id)
        Events::PaymentRequest::Rejected.create!(payment_request_record: payment_request_record,
                                                 message_id: message_id)
        payment_request_record.rejected!
      end

      ack!
    end
  end
end
