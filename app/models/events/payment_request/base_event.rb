module Events
  module PaymentRequest
    class BaseEvent < Abstract
      self.abstract_class = true
      self.table_name = 'payment_request_events'

      belongs_to :payment_request, class_name: '::PaymentRequest'
    end
  end
end
