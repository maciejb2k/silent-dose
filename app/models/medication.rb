# == Schema Information
#
# Table name: medications
#
#  id                  :uuid             not null, primary key
#  description         :text
#  form                :integer          default("tablets"), not null
#  manufacturer        :string           not null
#  meta                :jsonb            not null
#  name                :string           not null
#  silent_manufacturer :string
#  silent_name         :string
#  silent_reminder     :text
#  unit                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :uuid             not null
#
# Indexes
#
#  index_medications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Medication < ApplicationRecord
  attr_accessor :remove_photo

  belongs_to :user

  has_many :daily_reports_medications, dependent: :nullify, class_name: "DailyReports::Medication"
  has_many :daily_reports, through: :daily_reports_medications

  has_one_attached :photo

  before_save :purge_photo, if: -> { remove_photo == "1" }

  enum :form, MedicationForm::FORMS

  validates :name, :form, :manufacturer, presence: true

  def display_name
    "#{name}"
  end

  def purge_photo
    photo.purge
  end
end
