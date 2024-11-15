# == Schema Information
#
# Table name: notification_histories
#
#  id            :uuid             not null, primary key
#  message       :text
#  provider_type :integer          default("discord"), not null
#  sent_at       :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :uuid             not null
#
# Indexes
#
#  index_notification_histories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class NotificationHistory < ApplicationRecord
  belongs_to :user

  enum :provider_type, ProviderType::TYPES

  validates :provider_type, presence: true, inclusion: { in: provider_types.keys }
  validates :sent_at, presence: true
end
