# == Schema Information
#
# Table name: users
#
#  id                                    :uuid             not null, primary key
#  discord_notifications_user            :string
#  email                                 :string           default(""), not null
#  email_notifications_address           :string
#  enable_auto_create_report             :boolean          default(FALSE)
#  enable_discord_notifications          :boolean          default(FALSE)
#  enable_discord_silent                 :boolean          default(FALSE)
#  enable_email_notifications            :boolean          default(FALSE)
#  enable_email_silent                   :boolean          default(FALSE)
#  enable_previous_day_reports           :boolean          default(FALSE)
#  enable_provider_notifications         :boolean          default(FALSE)
#  enable_sms_notifications              :boolean          default(FALSE)
#  enable_sms_silent                     :boolean          default(FALSE)
#  encrypted_password                    :string           default(""), not null
#  previous_day_report_email             :string
#  previous_day_report_notification_time :time
#  remember_created_at                   :datetime
#  reset_password_sent_at                :datetime
#  reset_password_token                  :string
#  role                                  :integer          default("user"), not null
#  settings                              :jsonb            not null
#  sms_notifications_phone_number        :string
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  daily_report_id                       :uuid
#
# Indexes
#
#  index_users_on_daily_report_id       (daily_report_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (daily_report_id => daily_reports.id)
#
class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :medications, dependent: :destroy
  has_many :daily_reports, dependent: :destroy, class_name: "DailyReport"
  has_many :daily_reports_medications, dependent: :destroy, class_name: "DailyReports::Medication"
  has_many :reminder_times, dependent: :destroy

  enum :role, { user: 0, admin: 1 }

  alias_attribute :user_id, :id

  validates :daily_report_id, presence: true, if: :enable_auto_create_report?

  def display_name
    email
  end
end
