# == Schema Information
#
# Table name: medications
#
#  id           :uuid             not null, primary key
#  description  :text
#  form         :integer          default("tablets"), not null
#  manufacturer :string           not null
#  meta         :jsonb            not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :uuid             not null
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
  belongs_to :user

  has_many :daily_reports_medications, dependent: :nullify, class_name: "DailyReports::Medication"
  has_many :daily_reports, through: :daily_reports_medications

  has_one_attached :photo

  enum form: {
    tablets: 0,
    capsules: 1,
    powders: 2,
    liquids: 3,
    syrups: 4,
    injections: 5,
    suppositories: 6,
    creams_and_ointments: 7,
    patches: 8,
    aerosols: 9,
    granules: 10,
    lozenges: 11,
    eye_and_ear_drops: 12,
    skin_solutions: 13,
    sachets: 14,
    sprays: 15,
    other: 16
  }

  validates :name, :form, :manufacturer, presence: true

  def display_name
    "#{name}"
  end
end
