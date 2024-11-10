class SchedulePreviousDayReportGenerationJob
  include Sidekiq::Job

  def perform
    User.where(previous_day_report_email: true).find_each do |user|
      return if user.previous_day_report_notification_time.blank?

      time = user.previous_day_report_notification_time
      return unless time.hour == Time.current.hour && time.min == Time.current.min

      PreviousDayReportGenerationJob.perform_async(user.id)
    end
  end
end
