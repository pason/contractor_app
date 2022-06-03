class CreatePaymentRequestEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_request_events, id: :uuid do |t|
      t.belongs_to :payment_request, null: false, foreign_key: true, type: :uuid
      t.string :event_type, null: false
      t.json :payload
      t.uuid :message_id, default: 'gen_random_uuid()'

      t.timestamps
    end
  end
end
