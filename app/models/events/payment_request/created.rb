module Events
  module PaymentRequest
    class Created < PaymentRequestEvent
      include Publishable
      routing_key 'payment_request.created'.freeze
    end
  end
end
