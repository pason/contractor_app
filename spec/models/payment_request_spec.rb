require 'rails_helper'

RSpec.describe PaymentRequestRecord, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:currency_code) }
    it { should validate_presence_of(:description) }
  end
end
