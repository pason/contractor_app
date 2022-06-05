require 'rails_helper'

RSpec.describe 'payment_requests/new', type: :view do
  before(:each) do
    assign(:payment_request_form, PaymentRequestForm.new(
      payment_request_record: PaymentRequestRecord.new(amount: '9.99', currency_code: 'USD', description: 'MyText'),
      event: Events::PaymentRequest::Created.new
    ))
  end

  it 'renders new payment_request form' do
    render

    assert_select 'form[action=?][method=?]', payment_requests_path, 'post' do
      assert_select 'input[name=?]', 'payment_request_form[amount]'

      assert_select 'select[name=?]', 'payment_request_form[currency_code]'

      assert_select 'textarea[name=?]', 'payment_request_form[description]'
    end
  end
end
