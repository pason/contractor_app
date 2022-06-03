module Events
  class PaymentRequestEvent < ApplicationRecord
    self.table_name = 'payment_request_events'

    belongs_to :payment_request, class_name: '::PaymentRequest'

    after_initialize do
      self.event_type = event_type
      self.payload ||= {}
    end

    def event_type
      self.class.to_s.split('::').last
    end
  end
end
