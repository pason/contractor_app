require 'rails_helper'

RSpec.describe "payment_requests/new", type: :view do
  before(:each) do
    assign(:payment_request, PaymentRequest.new(
      amount: "9.99",
      8: "MyString",
      2: "MyString",
      currency_iso: "MyString",
      description: "MyText"
    ))
  end

  it "renders new payment_request form" do
    render

    assert_select "form[action=?][method=?]", payment_requests_path, "post" do

      assert_select "input[name=?]", "payment_request[amount]"

      assert_select "input[name=?]", "payment_request[8]"

      assert_select "input[name=?]", "payment_request[2]"

      assert_select "input[name=?]", "payment_request[currency_iso]"

      assert_select "textarea[name=?]", "payment_request[description]"
    end
  end
end
