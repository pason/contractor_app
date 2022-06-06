module AmqpService
  def self.publish(event:)
    Amqp::Publisher::Topic.publish(topic: Rails.application.credentials.config.dig(:amqp, :exchange),
                                   routing_key: event.routing_key,
                                   message_id: event.message_id,
                                   payload: event.payload.to_json
                                  )
  end
end
