require 'rails_helper'

RSpec.describe 'payment_requests/index', type: :view do
  before(:each) do
    assign(:payment_requests, [
      create(:payment_request_record),
      create(:payment_request_record)
    ])
  end

  it 'renders a list of payment_requests' do
    render
    assert_select 'tr>td', text: '$9.99'.to_s, count: 2
    assert_select 'tr>td', text: 'payment request'.to_s, count: 2
    assert_select 'tr>td', text: 'pending'.to_s, count: 2
  end
end
