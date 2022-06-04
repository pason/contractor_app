require 'amqp'
require 'amqp/config'

Amqp::Config.config do |config|
  config.app_id = 'contractor_app'
  config.host = '127.0.0.1'
  config.user = 'guest'
  config.pass = 'guest'
  config.port = '5672'
end