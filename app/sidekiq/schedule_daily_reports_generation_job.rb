class ScheduleDailyReportsGenerationJob
  include Sidekiq::Job

  def perform
    User.where(enable_auto_create_report: true).find_each do |user|
      return if user.daily_report_id.blank?

      DailyReportGenerationJob.perform_async(user.id, user.daily_report_id)
    end
  end
end
