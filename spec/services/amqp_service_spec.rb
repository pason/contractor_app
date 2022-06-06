require 'rails_helper'

RSpec.describe AmqpService, type: :service do
  describe 'class method' do
    it 'publishes event' do
      payment_request_record = create(:payment_request_record)
      event = create(:event_created, payment_request_record: payment_request_record)

      publish = double("AmqpService.publish")
      allow(publish).to receive(:event).and_return(true)

      expect(event).to respond_to(:routing_key)
      expect(AmqpService.publish(event: event)).to be_truthy
    end
  end
end
