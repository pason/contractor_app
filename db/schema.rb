# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_602_143_925) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'payment_request_events', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'payment_request_id', null: false
    t.string 'event_type', null: false
    t.json 'payload'
    t.uuid 'message_id', default: -> { 'gen_random_uuid()' }
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['payment_request_id'], name: 'index_payment_request_events_on_payment_request_id'
  end

  create_table 'payment_requests', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.decimal 'amount', precision: 8, scale: 2, null: false
    t.string 'currency_code', null: false
    t.text 'description', null: false
    t.integer 'status', default: 10, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'payment_request_events', 'payment_requests'
end
