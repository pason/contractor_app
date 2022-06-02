module Events
  module PaymentRequest
    class Created < BaseEvent
      routing_key 'payment_request.created'.freeze
    end
  end
end
