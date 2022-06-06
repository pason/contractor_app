module Amqp
  class Connection
    attr_reader :adapter

    def initialize(adapter: Bunny)
      @adapter = adapter.new(Amqp::Config.connection_string)
      @adapter.start
    end
  end
end