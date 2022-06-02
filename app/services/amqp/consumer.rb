module Amqp
  class Consumer
    attr_reader :adapter

    def initialize(adapter: Bunny.new)
      @adapter = adapter
    end

    def consume
      adapter.start
      channel = adapter.create_channel
      exchange = channel.topic('payments', durable: true)
      channel.queue('', exclusive: true)
             .bind(exchange, routing_key: 'topic.queue')
             .subscribe(block: true) do |delivery_info, _properties, body|
        puts " [x] #{delivery_info.routing_key}:#{body}"
      end

      adapter.close
    end
  end
end
