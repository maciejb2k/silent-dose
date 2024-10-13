require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SilentDose
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    Rails.configuration.to_prepare do
      module RansackableAttachment
        def ransackable_attributes(_auth_object = nil)
          %w[blob_id created_at id id_value name record_id record_type]
        end
      end

      ActiveSupport.on_load(:active_storage_attachment) do
        ActiveStorage::Attachment.extend RansackableAttachment
      end
    end

    # Setup the Active Job queue adapter to be Sidekiq
    config.active_job.queue_adapter = :sidekiq

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.generators do |g|
      g.test_framework nil
    end
  end
end
