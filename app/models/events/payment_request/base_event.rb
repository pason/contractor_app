module Events
  module PaymentRequest
    class BaseEvent < ApplicationRecord
      include Publishable
      include Eventable

      self.table_name = 'payment_request_events'
      belongs_to :payment_request, class_name: '::PaymentRequest'
    end
  end
end
