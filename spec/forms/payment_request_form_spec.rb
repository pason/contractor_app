require 'rails_helper'

RSpec.describe PaymentRequestForm, type: :form do
  let(:valid_attributes) do
    { amount: 1000, currency_code: 'USD', description: 'payment' }
  end

  let(:invalid_attributes) do
    { amount: '', currency_code: 'USD', description: 'payment' }
  end

  describe "submit" do
    context "valid attributes" do
      it 'creates an event' do
        form = PaymentRequestForm.new(payment_request_record: PaymentRequestRecord.new,
                                      event: Events::PaymentRequest::Created.new)

        expect{ form.submit(valid_attributes) }.to change(Events::PaymentRequest::Created, :count).by(1)

        event = Events::PaymentRequestEvent.last
        expect(event.event_type).to eq('created')
        expect(event.payload).to eq(valid_attributes.stringify_keys.merge('id' => event.payload['id']))
      end
      it 'creates a payment request record' do
        form = PaymentRequestForm.new(payment_request_record: PaymentRequestRecord.new,
                                      event: Events::PaymentRequest::Created.new)

        expect{ form.submit(valid_attributes) }.to change(PaymentRequestRecord, :count).by(1)
        payment_record = PaymentRequestRecord.last
        expect(payment_record.amount).to eq 1000
        expect(payment_record.currency_code).to eq 'USD'
        expect(payment_record.description).to eq 'payment'
      end
    end

    context "invalid attributes" do
      it 'not saves the form' do
        form = PaymentRequestForm.new(payment_request_record: PaymentRequestRecord.new,
                                      event: Events::PaymentRequest::Created.new)

        expect(form.submit(invalid_attributes)).to be_falsey
      end
    end
  end
end