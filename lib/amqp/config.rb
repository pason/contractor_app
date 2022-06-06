module Amqp
  class Config
    mattr_accessor :app_id, :host, :port, :user, :pass, :on_return_performer

    def self.config
      yield self
    end

    def self.connection_string
      "amqp://#{user}:#{pass}@#{host}:#{port}"
    end
  end
end