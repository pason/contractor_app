json.extract! payment_request, :id, :amount, :currency_iso, :description, :created_at, :updated_at
json.url payment_request_url(payment_request, format: :json)
