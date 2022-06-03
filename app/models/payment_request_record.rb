class PaymentRequestRecord < ApplicationRecord
  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :currency_code, presence: true
  validates :description, presence: true

  module Statuses
    PENDING = :pending
    ACCEPTED = :accepted
    REJECTED = :rejected
  end

  enum status: {
    Statuses::PENDING => 10,
    Statuses::ACCEPTED => 20,
    Statuses::REJECTED => 30
  }
end
