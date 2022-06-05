class CreatePaymentRequestRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_request_records, id: :uuid do |t|
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.string :currency_code, null: false
      t.text :description, null: false
      t.integer :status, null: false, default: 10

      t.timestamps
    end
  end
end
