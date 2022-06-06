require 'rails_helper'

RSpec.describe Amqp::Config, type: :service do
  describe 'class method' do
    it 'generates valid connection string' do
      Amqp::Config.config do |config|
        config.app_id = 'manager_app'
        config.host = '127.0.0.1'
        config.user = 'guest'
        config.pass = 'guest'
        config.port = '5672'
      end

      expect(Amqp::Config.connection_string).to eq("amqp://guest:guest@127.0.0.1:5672")
    end
  end
end