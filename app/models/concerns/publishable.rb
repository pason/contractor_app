module Publishable
  extend ActiveSupport::Concern

  def publish
    amqp.publish(event: self)
  end

  def routing_key
    self.class.instance_variable_get(:@routing_key)
  end

  class_methods do
    def routing_key(routing_key)
      @routing_key = routing_key
    end
  end

  private

  def amqp
    @amqp ||= AmqpService
  end
end
