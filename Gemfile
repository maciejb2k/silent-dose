source "https://rubygems.org"

# General
gem "rails", "~> 7.2.1"
gem "sprockets-rails"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "sassc-rails"
gem "rails-i18n", "~> 7.0.0"
gem "bootstrap", "~> 5.3.3"
gem "autoprefixer-rails"
gem "jquery-rails"

gem "pagy", "~> 9.1"

# ActiveAdmin
gem "activeadmin"
gem "arctic_admin"
gem "activeadmin-sortable"
gem "activeadmin_addons"
gem "activeadmin_json_editor", "~> 0.0.7"

# Authentication and Authorization
gem "devise"
gem "pundit"

# Integrations
gem "discordrb"

# Utilities
gem "acts_as_list"
gem "simple_calendar"

# Background Jobs
gem "sidekiq"
gem "sidekiq-cron", "2.0.0.rc2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "dotenv"
end

group :development do
  gem "web-console"
  gem "annotate"
end
