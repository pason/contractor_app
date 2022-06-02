module Publishable
  extend ActiveSupport::Concern

  def publish!
    Amqp.publish(event: self)
  end

  def routing_key
    self.class.instance_variable_get(:@routing_key)
  end

  class_methods do
    def routing_key(routing_key)
      @routing_key = routing_key
    end
  end
end