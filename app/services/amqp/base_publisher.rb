module Amqp
  class BasePublisher
    def self.publish
      raise NotImplementedError
    end

    def self.channel
      @channel ||= connection.adapter.create_channel
    end

    def self.connection
      @connection ||= Connection.new
    end
  end
end
