class AddSettingsFieldsToUser < ActiveRecord::Migration[7.2]
  def change
    # Settings
    add_column :users, :settings, :jsonb, null: false, default: {}

    # Previous day report
    add_column :users, :enable_previous_day_reports, :boolean, default: false
    add_column :users, :previous_day_report_notification_time, :time
    add_column :users, :previous_day_report_email, :string

    # Auto create report
    add_column :users, :enable_auto_create_report, :boolean, default: false
    add_reference :users, :daily_report, foreign_key: true, type: :uuid

    # Global notifications enable
    add_column :users, :enable_provider_notifications, :boolean, default: false

    # Discord
    add_column :users, :enable_discord_notifications, :boolean, default: false
    add_column :users, :discord_notifications_user, :string

    # Email
    add_column :users, :enable_email_notifications, :boolean, default: false
    add_column :users, :email_notifications_address, :string

    # SMS
    add_column :users, :enable_sms_notifications, :boolean, default: false
    add_column :users, :sms_notifications_phone_number, :string
  end
end
