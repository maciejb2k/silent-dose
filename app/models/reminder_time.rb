# == Schema Information
#
# Table name: reminder_times
#
#  id         :uuid             not null, primary key
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_reminder_times_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ReminderTime < ApplicationRecord
  belongs_to :user

  validates :time, presence: true

  def full_name
    time.strftime("%H:%M")
  end
end
