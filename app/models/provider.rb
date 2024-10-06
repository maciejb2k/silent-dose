# == Schema Information
#
# Table name: providers
#
#  id            :uuid             not null, primary key
#  config        :jsonb            not null
#  description   :text
#  name          :string           not null
#  provider_type :integer          default("discord"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_providers_on_provider_type  (provider_type) UNIQUE
#
class Provider < ApplicationRecord
  enum :provider_type, ProviderType::TYPES

  validates :name, presence: true
  validates :config, presence: true, allow_blank: true
  validates :provider_type, uniqueness: true, presence: true, inclusion: { in: provider_types.keys }
end
