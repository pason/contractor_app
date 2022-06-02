module Amqp
  class Connection
    attr_reader :adapter

    def initialize(adapter: Bunny.new)
      # This is a place to put any specific RabbitMQ settings like host or port
      @adapter = adapter.tap do |c|
        c.start
      end
    end
  end
end
