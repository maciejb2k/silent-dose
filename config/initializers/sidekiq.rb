Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end

Sidekiq::Cron::Job.create(
  name: "Schedule Daily Reports - midnight",
  cron: "0 0 * * *", # Run at midnight every day
  class: "ScheduleDailyReportsGenerationJob"
)
