require 'rails_helper'

RSpec.describe '/payment_requests', type: :request do
  let(:valid_attributes) do
    { amount: 1000, currency_code: 'USD', description: 'payment' }
  end

  let(:invalid_attributes) do
    { amount: '', currency_code: 'USD', description: 'payment' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      PaymentRequestRecord.create! valid_attributes
      get payment_requests_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_payment_request_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new PaymentRequest' do
        expect do
          post payment_requests_url, params: { payment_request_form: valid_attributes }
        end.to change(PaymentRequestRecord, :count).by(1)
           .and change(Events::PaymentRequest::Created, :count).by(1)
      end

      it 'redirects to the created payment_request' do
        post payment_requests_url, params: { payment_request_form: valid_attributes }
        expect(response).to redirect_to(payment_requests_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new PaymentRequest' do
        expect do
          post payment_requests_url, params: { payment_request_form: invalid_attributes }
        end.to change(PaymentRequestRecord, :count).by(0)
           .and change(Events::PaymentRequest::Created, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post payment_requests_url, params: { payment_request_form: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end
end
