class PaymentRequestsController < ApplicationController
  before_action :set_payment_request_form, only: %i[new create]

  def index
    @payment_requests = PaymentRequest.all
  end

  def new; end

  def create
    respond_to do |format|
      if @payment_request_form.submit(payment_request_params)
        format.html { redirect_to payment_requests_url, notice: 'Payment request was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def payment_request_params
    params.require(:payment_request_form).permit(:amount, :currency_code, :description)
  end

  def set_payment_request_form
    @payment_request_form = PaymentRequestForm.new
  end
end
