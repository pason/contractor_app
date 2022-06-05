class PaymentRequestForm
  include ActiveModel::Model

  attr_accessor :amount, :currency_code, :description, :payment_request_record, :event

  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :currency_code, presence: true
  validates :description, presence: true

  def initialize(event:, payment_request_record:)
    @payment_request_record = payment_request_record
    @event = event
  end

  def submit(params = {})
    assign_attributes(params)
    return false unless valid?

    ActiveRecord::Base.transaction do
      payment_request_record.assign_attributes(payload)
      event.assign_attributes(payment_request_record: payment_request_record, payload: payload)
      payment_request_record.save!
      event.save!
    end

  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
    false
  end

  private

  def payload
    {
      id: SecureRandom.hex,
      amount: amount.presence,
      currency_code: currency_code.presence,
      description: description.presence
    }
  end
end
