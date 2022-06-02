require 'rails_helper'

RSpec.describe "payment_requests/index", type: :view do
  before(:each) do
    assign(:payment_requests, [
      PaymentRequest.create!(
        amount: "9.99",
        8: "8",
        2: "2",
        currency_iso: "Currency Iso",
        description: "MyText"
      ),
      PaymentRequest.create!(
        amount: "9.99",
        8: "8",
        2: "2",
        currency_iso: "Currency Iso",
        description: "MyText"
      )
    ])
  end

  it "renders a list of payment_requests" do
    render
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "8".to_s, count: 2
    assert_select "tr>td", text: "2".to_s, count: 2
    assert_select "tr>td", text: "Currency Iso".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
