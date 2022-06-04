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

    def self.on_return_handler
      @on_return_handler ||= OnReturnHandler.new(performer: UndeliveredMessagesRetryJob)
    end
  end
end
