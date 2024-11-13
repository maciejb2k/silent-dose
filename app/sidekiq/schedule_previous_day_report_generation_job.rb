class SchedulePreviousDayReportGenerationJob
  include Sidekiq::Job

  def perform
    User.where(enable_previous_day_reports: true).find_each do |user|
      return if user.previous_day_report_notification_time.blank?

      now = Time.current
      hour = user.previous_day_report_notification_time.hour
      minute = user.previous_day_report_notification_time.min

      PreviousDayReportGenerationJob.perform_async(user.id) if now.hour == hour && now.min == minute
    end
  end
end
