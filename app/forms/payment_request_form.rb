class PaymentRequestForm
  include ActiveModel::Model

  attr_accessor :amount, :currency_code, :description
  attr_reader :payment_request_record, :event

  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :currency_code, presence: true
  validates :description, presence: true

  def initialize
    @payment_request_record = PaymentRequestRecord.new
    @event = Events::PaymentRequest::Created.new
  end

  def submit(params = {})
    assign_attributes(params)
    return false unless valid?

    ActiveRecord::Base.transaction do
      payment_request_record.assign_attributes(payload)
      event.assign_attributes(payment_request_record: payment_request_record, payload: payload)
      payment_request_record.save!
      event.save!
      event.publish!
    end
  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
    false
  rescue Bunny::Exception => e
    # Log notification to App Monitor tool
    Rails.logger.error "Error: #{e}\n#{Kernel.caller.join("\n")}"
    false
  end

  private

  def payload
    {
      amount: amount.presence,
      currency_code: currency_code.presence,
      description: description.presence
    }
  end
end
