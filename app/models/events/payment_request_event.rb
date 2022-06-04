module Events
  class PaymentRequestEvent < ApplicationRecord
    belongs_to :payment_request_record

    after_initialize do
      self.message_id ||= SecureRandom.uuid
    end
  end
end
