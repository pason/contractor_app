FactoryBot.define do
  factory :payment_request_record, class: "PaymentRequestRecord" do
    amount { 9.99 }
    currency_code { 'USD' }
    description { 'payment request' }
  end
end