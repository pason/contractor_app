module Amqp
  module Publisher
    class Topic < BasePublisher
      def self.publish(topic:, routing_key:, payload:)
        exchange = channel.topic(topic, durable: true)
        exchange.publish(payload, routing_key:, persistent: true, mandatory: true)

        exchange.on_return do |_return_info, _properties, content|
          puts "Got a returned message: #{content}"
        end
      end
    end
  end
end
