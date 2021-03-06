FactoryBot.define do
  factory :event_created, class: "Events::PaymentRequest::Created" do
    payload { { id: SecureRandom.uuid}  }
  end
end