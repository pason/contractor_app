require 'rails_helper'

RSpec.describe Events::PaymentRequestEvent, type: :model do
  describe "Associations" do
    it { should belong_to(:payment_request_record) }
  end

  describe "callbacks" do
    context "on initialize" do
      it 'creates message_id' do
        expect(Events::PaymentRequestEvent.new.message_id).to_not be_empty
      end
    end
  end
end
