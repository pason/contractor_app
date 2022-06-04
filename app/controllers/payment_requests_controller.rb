class PaymentRequestsController < ApplicationController
  before_action :set_payment_request_form, only: %i[new create]

  def index
    @payment_requests = PaymentRequestRecord.all
  end

  def new; end

  def create
    if @payment_request_form.submit(payment_request_params)
       @event.publish
      redirect_to payment_requests_url, notice: 'Payment request was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def payment_request_params
    params.require(:payment_request_form).permit(:amount, :currency_code, :description)
  end

  def set_payment_request_form
    @payment_request_record = PaymentRequestRecord.new
    @event = Events::PaymentRequest::Created.new
    @payment_request_form = PaymentRequestForm.new(payment_request_record: @payment_request_record, event: @event)
  end
end