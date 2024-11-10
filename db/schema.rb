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

ActiveRecord::Schema[7.2].define(version: 2024_11_10_114230) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "daily_reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "report_date"
    t.boolean "is_completed", default: false, null: false
    t.boolean "is_template", default: false, null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "report_date"], name: "index_daily_reports_on_user_id_and_report_date", unique: true, where: "(is_template = false)"
    t.index ["user_id"], name: "index_daily_reports_on_user_id"
  end

  create_table "daily_reports_medications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "dosage", default: "", null: false
    t.boolean "taken", default: false, null: false
    t.integer "position", null: false
    t.datetime "intake_time"
    t.string "medication_name"
    t.string "medication_manufacturer"
    t.string "medication_form"
    t.uuid "medication_id"
    t.uuid "daily_report_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "silent_name"
    t.string "silent_manufacturer"
    t.text "silent_reminder"
    t.index ["daily_report_id", "position"], name: "idx_on_daily_report_id_position_dbfe078fa8", unique: true
    t.index ["daily_report_id"], name: "index_daily_reports_medications_on_daily_report_id"
    t.index ["medication_id"], name: "index_daily_reports_medications_on_medication_id"
    t.index ["user_id"], name: "index_daily_reports_medications_on_user_id"
  end

  create_table "medications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "manufacturer", null: false
    t.integer "form", default: 0, null: false
    t.string "unit"
    t.jsonb "meta", default: {}, null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "silent_name"
    t.string "silent_manufacturer"
    t.text "silent_reminder"
    t.index ["user_id"], name: "index_medications_on_user_id"
  end

  create_table "providers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "provider_type", default: 0, null: false
    t.jsonb "config", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_type"], name: "index_providers_on_provider_type", unique: true
  end

  create_table "reminder_times", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reminder_times_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.jsonb "settings", default: {}, null: false
    t.boolean "enable_previous_day_reports", default: false
    t.time "previous_day_report_notification_time"
    t.string "previous_day_report_email"
    t.boolean "enable_auto_create_report", default: false
    t.uuid "daily_report_id"
    t.boolean "enable_provider_notifications", default: false
    t.boolean "enable_discord_notifications", default: false
    t.boolean "enable_discord_silent", default: false
    t.string "discord_notifications_user"
    t.boolean "enable_email_notifications", default: false
    t.boolean "enable_email_silent", default: false
    t.string "email_notifications_address"
    t.boolean "enable_sms_notifications", default: false
    t.boolean "enable_sms_silent", default: false
    t.string "sms_notifications_phone_number"
    t.index ["daily_report_id"], name: "index_users_on_daily_report_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "daily_reports", "users"
  add_foreign_key "daily_reports_medications", "daily_reports"
  add_foreign_key "daily_reports_medications", "medications"
  add_foreign_key "daily_reports_medications", "users"
  add_foreign_key "medications", "users"
  add_foreign_key "reminder_times", "users"
  add_foreign_key "users", "daily_reports"
end
