class ScheduleDailyReportsGenerationJob
  include Sidekiq::Job

  def perform
    User.where(enable_auto_create_report: true).find_each do |user|
      DailyReportGenerationJob.perform_async(user.id, user.daily_report_id) if user.daily_report_id.present?
    end
  end
end
