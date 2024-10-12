# == Schema Information
#
# Table name: daily_reports
#
#  id           :uuid             not null, primary key
#  description  :text
#  is_completed :boolean          default(FALSE), not null
#  is_template  :boolean          default(FALSE), not null
#  report_date  :date             not null
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :uuid             not null
#
# Indexes
#
#  index_daily_reports_on_user_id                  (user_id)
#  index_daily_reports_on_user_id_and_report_date  (user_id,report_date) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class DailyReport < ApplicationRecord
  belongs_to :user

  has_many :daily_reports_medications, dependent: :destroy, class_name: "DailyReports::Medication"
  has_many :medications, through: :daily_reports_medications

  accepts_nested_attributes_for :daily_reports_medications, allow_destroy: true

  validates :report_date, presence: true
  validates :report_date, uniqueness: { scope: :user_id }

  scope :completed, -> { where(is_completed: true) }
  scope :templates, -> { where(is_template: true) }
  scope :reports, -> { where(is_template: false) }

  def display_name
    title.presence || "#{report_date}" || "Daily Report"
  end

  def update_completion_status
    update(is_completed: daily_reports_medications.all?(&:taken?))
  end
end
