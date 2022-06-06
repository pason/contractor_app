module Amqp
  module Publisher
    class Topic < BasePublisher
      def self.publish(topic:, routing_key:, message_id:, payload:)
        exchange = channel.topic(topic, durable: true)
        exchange.publish(payload, routing_key: routing_key,
                                  message_id: message_id,
                                  app_id: Config.app_id,
                                  persistent: true,
                                  mandatory: true)

        exchange.on_return do |return_info, properties, content|
          on_return_handler.call(return_info, properties, content)
        end
      end
    end
  end
end