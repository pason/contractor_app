require 'rails_helper'

RSpec.describe 'payment_requests/show', type: :view do
  before(:each) do
    @payment_request = assign(:payment_request, PaymentRequest.create!(
                                                  amount: '9.99',
                                                  currency_iso: 'Currency Iso',
                                                  description: 'MyText'
                                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Currency Iso/)
    expect(rendered).to match(/MyText/)
  end
end
