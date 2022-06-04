module Amqp
  APP_ID = 'contractor_app'.freeze

  def self.publish(event:)
    Publisher::Topic.publish(topic: Rails.application.credentials.config.dig(:amqp, :exchange),
                             routing_key: event.routing_key,
                             message_id: event.message_id,
                             app_id: APP_ID,
                             payload: event.payload.to_json
                             )
  end
end
