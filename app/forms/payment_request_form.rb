class PaymentRequestForm
  include ActiveModel::Model

  attr_accessor :amount, :currency_code, :description
  attr_reader :payment_request, :event_created

  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :currency_code, presence: true
  validates :description, presence: true

  def initialize
    @payment_request = PaymentRequest.new
    @event_created = Events::PaymentRequest::Created
  end

  def submit(params = {})
    assign_attributes(params)
    return false unless valid?

    ActiveRecord::Base.transaction do
      payment_request.assign_attributes(payment_request_attributes)
      payment_request.save!
      event_created.create!(payment_request:,
                            payload: event_payload)
    end
  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
    false
  end

  private

  def payment_request_attributes
    {
      amount: amount.presence,
      currency_code: currency_code.presence,
      description: description.presence
    }
  end

  def event_payload
    payment_request_attributes.merge({ external_id: payment_request.id })
  end
end
