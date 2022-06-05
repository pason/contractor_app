require 'rails_helper'

RSpec.describe Amqp::Config, type: :service do
  describe 'class method' do
    it 'publishes event' do
      payment_request_record = create(:payment_request_record)
      event = create(:event_created, payment_request_record: payment_request_record)

      publish = double("Amqp::publish")
      allow(publish).to receive(:event).and_return(true)

      expect(event).to respond_to(:routing_key)
      expect(Amqp::publish(event: event)).to be_truthy
    end
  end
end