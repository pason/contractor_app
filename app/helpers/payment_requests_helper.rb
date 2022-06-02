module PaymentRequestsHelper
  def currency_codes
    list = Money::Currency.table.values.map { |s| s[:iso_code] }
    list.insert(0, list.delete('USD'))
    list
  end
end
