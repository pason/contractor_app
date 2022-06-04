class CreatePaymentRequestEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_request_events, id: :uuid do |t|
      t.belongs_to :payment_request_record, null: false, foreign_key: true, type: :uuid
      t.string :type, null: false, index: true
      t.json :payload
      t.uuid :message_id

      t.timestamps
    end
  end
end
