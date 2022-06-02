module Amqp
  def self.publish(routing_key:, payload:)
    Publisher::Topic.publish(topic: Rails.application.credentials.config.dig(:amqp, :exchange),
                             routing_key:,
                             payload:)
  end
end
