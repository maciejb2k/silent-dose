# == Schema Information
#
# Table name: daily_reports_medications
#
#  id                      :uuid             not null, primary key
#  dosage                  :string           default(""), not null
#  intake_time             :datetime
#  medication_form         :string
#  medication_manufacturer :string
#  medication_name         :string
#  position                :integer          not null
#  silent_manufacturer     :string
#  silent_name             :string
#  silent_reminder         :text
#  taken                   :boolean          default(FALSE), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  daily_report_id         :uuid             not null
#  medication_id           :uuid
#  user_id                 :uuid             not null
#
# Indexes
#
#  index_daily_reports_medications_on_daily_report_id  (daily_report_id)
#  index_daily_reports_medications_on_medication_id    (medication_id)
#  index_daily_reports_medications_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (daily_report_id => daily_reports.id)
#  fk_rails_...  (medication_id => medications.id)
#  fk_rails_...  (user_id => users.id)
#
class DailyReports::Medication < ApplicationRecord
  belongs_to :medication, optional: true
  belongs_to :daily_report
  belongs_to :user

  validates :dosage, presence: true
  validates :medication, presence: true, unless: -> { medication.nil? && persisted? }

  acts_as_list scope: :daily_report

  before_save :store_medication_details
  after_save :update_daily_report_completion

  private

  def store_medication_details
    return unless medication.present?

    self.medication_name ||= medication.name
    self.medication_manufacturer ||= medication.manufacturer
    self.medication_form ||= medication.form
    self.silent_name ||= medication.silent_name
    self.silent_manufacturer ||= medication.silent_manufacturer
    self.silent_reminder ||= medication.silent_reminder
  end

  def update_daily_report_completion
    daily_report.update_completion_status
  end
end
