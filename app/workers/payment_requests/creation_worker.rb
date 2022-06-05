module PaymentRequests
  class CreationWorker
    include Sneakers::Worker

    from_queue 'contractor_payment_request_created',
               routing_key: 'payment_request.created',
               durable: true

    def work_with_params(msg, _delivery_info, metadata)
      message_id = metadata[:message_id]
      payload = ActiveSupport::JSON.decode(msg)&.with_indifferent_access

      event = Events::PaymentRequest::Created.new
      payment_request_record = PaymentRequestRecord.new

      ActiveRecord::Base.transaction do
        event.assign_attributes(payload: payload,
                                message_id: message_id,
                                payment_request_record: payment_request_record)

        payment_request_record.assign_attributes(payload)

        event.save!
        payment_request_record.save!
      end

      ack!
    end
  end
end
